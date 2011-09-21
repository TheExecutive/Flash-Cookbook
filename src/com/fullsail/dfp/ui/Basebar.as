package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.SearchEvent;
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import libs.BasebarBase;
	
	
	public class Basebar extends BasebarBase
	{
		
		private var _listArray:Array;
		private var _searchedFor:String;
		private var _isSearching:Boolean = false;
		private var _textField:String;
		
		public function Basebar()
		{
			super();
			mc_bugButton.stop();
			mc_bugButton.buttonMode = true;
			mc_bugButton.mouseChildren = false;
			mc_bugButton.addEventListener(MouseEvent.CLICK,onBugClick);
		}
		
		protected function onBugClick(event:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.facebook.com/FlashCookBook?sk=wall"), "_blank");
		}
		
		private function updateBasebar():void
		{
			var numResults:String = String(_listArray.length);
			
			if(_isSearching)
			{
				tfNotificationBar.text = 'Searching: "' + _searchedFor + '." Showing ' + numResults + ' results.';
			}else{
				tfNotificationBar.text = "Showing " + numResults + " results.";
			}
			
		}
		
		public function clearNotifications():void
		{
			tfNotificationBar.text = "";
		}

		public function set searchedFor(value:String):void
		{
			_searchedFor = value;
		}

		public function set listArray(value:Array):void
		{
			_listArray = value;
			updateBasebar();
		}

		public function set isSearching(value:Boolean):void
		{
			_isSearching = value;
		}

		public function set textField(value:String):void
		{
			_textField = value;
			tfNotificationBar.text = _textField;
			updateBasebar();
		}

		
	}
}