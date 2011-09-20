package com.fullsail.dfp.filters
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SearchFilter extends EventDispatcher
	{
		private static var _search:String
		
		public function SearchFilter(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function isAll(element:*, index:int, arr:Array):Boolean
		{
			//if all is clicked, just return true for every value
			return true;
		}
		public static function isFFM(element:*, index:int, arr:Array):Boolean
		{
			return element.course.toUpperCase() == "FFM";
		}
		public static function isOOP(element:*, index:int, arr:Array):Boolean
		{
			return element.course.toUpperCase() == "OOP";
		}
		public static function isFAT(element:*, index:int, arr:Array):Boolean
		{
			return element.course.toUpperCase() == "FAT";
		}
		public static function isDFP(element:*, index:int, arr:Array):Boolean
		{
			return element.course.toUpperCase() == "DFP";
		}
		private static function isSearched(element:*, index:int, arr:Array):Boolean
		{
			// if the keywords contains what you searched and what you searched is not just a comma
			return element.keywords.indexOf(_search) != -1 && _search != ",";
		}
		
		public static function searchFor(search:String,array:Array):Array
		{
			_search = search;
			if(_search == null)
			{
				//if there's no search yet
				//just return the original array without filtering
				return array;
			}
			
			return array.filter(isSearched);
		}
	}
}