package com.fullsail.dfp.events
{
	import flash.events.Event;
	
	public class XMLEvent extends Event
	{
		public static const DATA_LOAD_COMPLETE:String = "XMLEvent.DATA_LOAD_COMPLETE";
		public var codeVOArray:Array;
		
		public function XMLEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}