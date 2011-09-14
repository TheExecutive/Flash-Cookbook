package com.fullsail.dfp.ui
{
	import flash.events.MouseEvent;
	
	import libs.SearchBtnBase;
	
	public class SearchButton extends SearchBtnBase
	{
		public function SearchButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
		}
	}
}