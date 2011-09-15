package com.fullsail.dfp.service
{
	import com.fullsail.dfp.events.ErrorEvent;
	import com.fullsail.dfp.events.XMLEvent;
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(name="XMLEvent.DATA_LOAD_COMPLETE", type="com.fullsail.dfp.events.XMLEvent")]
	[Event(name="ErrorEvent.LOAD_ERROR", type="com.fullsail.dfp.events.ErrorEvent")]
	public class XMLService extends EventDispatcher
	{
		public function XMLService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search(query:String = ""):void
		{
			//for testing, the default value for search is an empty string
			loadXML("xmlList_v1_91511.xml");
		}
		
		private function loadXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,onLoad);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.load(new URLRequest(url));
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			trace("XML failed to load",event);
			var eEvent:ErrorEvent = new ErrorEvent(ErrorEvent.LOAD_ERROR);
			dispatchEvent(eEvent); //dispatching an error event
			//to let main know that an error has occured
		}
		
		protected function onLoad(event:Event):void
		{
			var xml:XML = new XML(event.target.data);
			trace(event.target.data);
			//creating a VO array to hold the VOs that will be taken
			//from XML
			var cVOArray:Array = [];
			
			for each(var snippet:XML in xml.snippets)
			{
				var cVO:CodeVO = new CodeVO();
				cVO.id = snippet.@id;
				cVO.course = snippet.@course;
				cVO.name = snippet.name;
				cVO.difficulty = snippet.difficulty;
				cVO.keywords = snippet.keywords.@text;
				cVO.codeString = snippet.code;
				cVO.notes = snippet.notes;
				cVO.resourcesLink = snippet.resources.link.@href;
				cVO.resourcesTitle = snippet.resources.link.@title;
				
				cVOArray.push(cVO);
				
			}
			
			//dispatching event when all this completes
			var xmlEvent:XMLEvent = new XMLEvent(XMLEvent.DATA_LOAD_COMPLETE);
			xmlEvent.codeVOArray = cVOArray; //passing the Array full of VOs along with the custom event
			dispatchEvent(xmlEvent);
			trace("xml event dispatched");
		}
	}
}