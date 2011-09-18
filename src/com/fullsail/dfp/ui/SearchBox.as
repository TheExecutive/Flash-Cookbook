package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.SearchEvent;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import libs.NewSB;
	
	public class SearchBox extends NewSB
	{
		private static const SEARCH_PROMPT:String = "I want info on...";
		
		public function SearchBox()
		{
			super();
			
			//search box attributes
			this.scaleX = this.scaleY = .75;
			this.x = 418;
			this.y = 55;
			
			//search button attributes
			var sbtn:SearchButton = new SearchButton();
			sbtn.y = 6;  
			sbtn.x = 213;
			this.addChild(sbtn);
			
			//search button event Listener
			sbtn.addEventListener(MouseEvent.CLICK, onSearchClick);
			
			//search box text attributes / listeners
			tfSearchInput.text = SEARCH_PROMPT;
			tfSearchInput.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			tfSearchInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			tfSearchInput.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.ENTER)
			{
				onSearch();
			}
		}
		
		private function onSearch():void
		{
			var se:SearchEvent = new SearchEvent(SearchEvent.SEARCH_QUERY);
			se.query = tfSearchInput.text;
			dispatchEvent(se);
		}
		private function onFocusIn(evt:FocusEvent):void
		{
			if(tfSearchInput.text == SEARCH_PROMPT)
			{
				tfSearchInput.text = "";
			}
		}
		private function onFocusOut(evt:FocusEvent):void 
		{
			if(tfSearchInput.text == "")
			{
				tfSearchInput.text = SEARCH_PROMPT;
			}
		}
		private function onSearchClick(evt:MouseEvent):void
		{
			onSearch();
		}
	}
}