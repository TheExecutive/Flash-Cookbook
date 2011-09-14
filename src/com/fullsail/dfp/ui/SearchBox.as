package com.fullsail.dfp.ui
{
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import libs.SearchBoxBase;
	
	public class SearchBox extends SearchBoxBase
	{
		public function SearchBox()
		{
			super();
			
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
	}
}