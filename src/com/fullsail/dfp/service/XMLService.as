package com.fullsail.dfp.service
{
	import com.fullsail.dfp.events.ErrorEvent;
	import com.fullsail.dfp.events.XMLEvent;
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(name="XMLEvent.DATA_LOAD_COMPLETE", type="com.fullsail.dfp.events.XMLEvent")]
	[Event(name="ErrorEvent.LOAD_ERROR", type="com.fullsail.dfp.events.ErrorEvent")]
	public class XMLService extends EventDispatcher
	{
		
		private const API_XML:String = "https://gist.github.com/raw/1227007/MasterSnippetXMList.xml";
		private const BACKUP_XML:String = "MasterXMLSnippets.xml";
		
		private var _alreadyErrored:Boolean = false;
		
		public function XMLService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function beginLoad():void
		{
			loadXML(API_XML);
			//API requirement
		}
		
		private function loadXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,onLoad);
			urlLoader.addEventListener(ProgressEvent.PROGRESS,onProgress);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.load(new URLRequest(url));
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			trace(event.bytesLoaded + " out of " + event.bytesTotal); 
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			trace("XML failed to load", event);
			if(!_alreadyErrored)
			{
				//if it hasn't already errored out, load the backup xml here
				loadXML(BACKUP_XML);
				_alreadyErrored = true;
			}else{
				trace("XML backup failed");
				var eEvent:ErrorEvent = new ErrorEvent(ErrorEvent.LOAD_ERROR);
				dispatchEvent(eEvent); //dispatching an error event
				//to let main know that an error has occured
			}
			
		}
		
		protected function onLoad(event:Event):void
		{
			var xml:XML = new XML(event.target.data);
			//creating a VO array to hold the VOs that will be taken
			//from XML
			var cVOArray:Array = [];
			
			for each(var snippet:XML in xml.snippet)
			{
				var cVO:CodeVO = new CodeVO();
				cVO.codeString = "";
				cVO.notes = "";
				cVO.id = snippet.@id;
				cVO.course = snippet.@course;
				cVO.name = snippet.name;
				cVO.difficulty = snippet.difficulty;
				cVO.keywords = snippet.keywords.@text;
				//fix to remove null from code view;
				if(snippet.code.length() == 1)
				{
					cVO.codeString = snippet.code;
					
				}else if(snippet.code.length() > 1)
				{
					for(var i:int = 0; i < snippet.code.length(); i++)
					{
						cVO.codeString += snippet.code[i] + "\n";
					}
				}
				//fix to remove notes node from notes view;
				if(snippet.notes.length() == 1)
				{
					cVO.notes = snippet.notes;
				}else if(snippet.notes.length() > 1)
				{
					for(var j:int = 0; j < snippet.notes.length(); j++)
					{
						cVO.notes += snippet.notes[j] + "\n";
					}
				}
				cVO.resourcesLink = snippet.resources.link.@href;
				cVO.resourcesTitle = snippet.resources.link.@title;
				
				//pushing parsed XML into array
				cVOArray.push(cVO);
				
			}
			
			if(cVOArray.length < 1)
			{
				//if the XML file has nothing in it, meaning there are no more API calls
				trace("Using Backup XML");
				loadXML(BACKUP_XML);
				_alreadyErrored = true;
			}else{
				//dispatching event when all this completes
				var xmlEvent:XMLEvent = new XMLEvent(XMLEvent.DATA_LOAD_COMPLETE);
				xmlEvent.codeVOArray = cVOArray; //passing the Array full of VOs along with the custom event
				dispatchEvent(xmlEvent);
			}
			
		}
		
	}
}