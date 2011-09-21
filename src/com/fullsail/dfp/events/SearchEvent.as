package com.fullsail.dfp.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const SEARCH_QUERY:String = "SearchEvent.SEARCH_QUERY";
		public static const UPDATE_NOTIFICATIONS:String = "SearchEvent.UPDATE_NOTIFICATIONS";
		public static const RESET_TO_ALL:String = "SearchEvent.RESET_TO_ALL";
		
		public var listArray:Array;
		public var query:String;
		public var isSearching:Boolean;
		
		public function SearchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			var se:SearchEvent = new SearchEvent(type, bubbles, cancelable);
			se.listArray = listArray;
			se.query = query;
			return se;
		}
	}
}