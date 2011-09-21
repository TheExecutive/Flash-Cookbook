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
			if(_search != ",") //if the keyword is not a comma
			{
				if(element.keywords.toLowerCase().indexOf(_search.toLowerCase()) != -1 || element.notes.toLowerCase().indexOf(_search.toLowerCase()) != -1 || element.name.toLowerCase().indexOf(_search.toLowerCase) != -1 )
				{
					//if the search appears anywhere in keywords or notes or name
					return true;
				}else{
					return false;
				}
			}
			
			return false;
			
			// if the keywords contains what you searched and what you searched is not just a comma
		}
		
		public static function searchFor(search:String,array:Array):Array
		{
			_search = search;
			if(_search == null)
			{
				//if there's no search yet
				//just return the original array without filtering
				return array;
			}else if(_search.charAt(_search.length - 1) == "s")
			{
				_search = _search.slice(0, _search.length - 1);
				//if what is searched for is plural, cut off the s at the end and search for that
			}
			
			return array.filter(isSearched);
		}
	}
}