package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.SearchEvent;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import libs.SearchBoxBase;
	
	public class SearchBox extends SearchBoxBase
	{
		public function SearchBox()
		{
			super();
			
			//search box attributes
			this.scaleX = this.scaleY = .75;
			this.x = 418;
			this.y = 60;
			
			//search button attributes
			var sbtn:SearchButton = new SearchButton();
			sbtn.y = 6;
			sbtn.x = 233;
			this.addChild(sbtn);
			
			//search button event Listener
			sbtn.addEventListener(MouseEvent.CLICK, onSearchClick);
			
			//search box text attributes / listeners
			tfSearchInput.text = "Search For Snippet";
			tfSearchInput.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			tfSearchInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		}
		private function onFocusIn(evt:FocusEvent):void
		{
			if(tfSearchInput.text == "Search For Snippet")
			{
				tfSearchInput.text = "";
			}
		}
		private function onFocusOut(evt:FocusEvent):void
		{
			if(tfSearchInput.text == "")
			{
				tfSearchInput.text = "Search For Snippet";
			}
		}
		private function onSearchClick(evt:MouseEvent):void
		{
			var se:SearchEvent = new SearchEvent(SearchEvent.SEARCH_QUERY);
			se.query = tfSearchInput.text;
			dispatchEvent(se);
			trace("mouse clicked");
		}
	}
}