package com.fullsail.dfp.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const SEARCH_QUERY:String = "SearchEvent.SEARCH_QUERY";
		public static const CLOSE_INDICATOR:String = "SearchEvent.CLOSE_INDICATOR";
		public var query:String;
		
		public function SearchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			var se:SearchEvent = new SearchEvent(type, bubbles, cancelable);
			return se;
		}
	}
}