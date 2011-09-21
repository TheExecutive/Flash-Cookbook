package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.SearchEvent;
	
	import flash.events.MouseEvent;
	
	import libs.BasebarBase;
	
	
	public class Basebar extends BasebarBase
	{
		
		private var _notification:String;
		
		public function Basebar()
		{
			super();
			
		}
		public function get notification():String
		{
			return _notification;
		}

		public function set notification(value:String):void
		{
			_notification = value;
			tfNotificationBar.text = _notification;
			updateBasebar();
		}
		
		private function updateBasebar():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function clearNotifications():void
		{
			tfNotificationBar.text = "";
		}
		
	}
}