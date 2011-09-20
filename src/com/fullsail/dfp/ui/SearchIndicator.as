package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.SearchEvent;
	
	import flash.events.MouseEvent;
	
	import libs.SearchIndicatorBase;
	
	public class SearchIndicator extends SearchIndicatorBase
	{
		
		private var _searchLabel:String;
		
		public function SearchIndicator()
		{
			super();
			
			//close button
			closeButton.stop();
			closeButton.buttonMode = true;
			closeButton.mouseChildren = false;
			
			
		}
		public function get searchLabel():String
		{
			return _searchLabel;
		}

		public function set searchLabel(value:String):void
		{
			_searchLabel = value;
			tfSearched.text = _searchLabel;
			updateSearchIndicator();
		}
		
		private function updateSearchIndicator():void
		{
			closeButton.addEventListener(MouseEvent.CLICK,onCloseClick);
		}
		protected function onCloseClick(event:MouseEvent):void
		{
			closeButton.removeEventListener(MouseEvent.CLICK,onCloseClick);
			trace("closing");
			var sEvent:SearchEvent = new SearchEvent(SearchEvent.CLOSE_INDICATOR);
			dispatchEvent(sEvent);
			
		}

	}
}