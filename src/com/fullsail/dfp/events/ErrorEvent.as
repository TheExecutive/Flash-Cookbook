package com.fullsail.dfp.events
{
	import flash.events.Event;
	
	public class ErrorEvent extends Event
	{
		public static const LOAD_ERROR:String = "ErrorEvent.LOAD_ERROR";
		public static const GENERAL_ERROR:String = "ErrorEvent.GENERAL_ERROR";
		
		public function ErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var ee:ErrorEvent = new ErrorEvent(type, bubbles, cancelable);
			return ee;
		}
	}
}