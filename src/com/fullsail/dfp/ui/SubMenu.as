package com.fullsail.dfp.ui
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class SubMenu
	{
		private var _listItems:Object = {"1_FFM Portal":"http://wddbs.com/FFM/class/", 
										"2_OOP Portal":"http://wddbs.com/~jmadsen/oop/videos/",
										"3_FAT Portal - N/A":"",
										"4_DFP Portal":"http://wddbs.com/dfp/",
										"5_Flash Cookbook Facebook Page":"https://www.facebook.com/FlashCookBook"};
		private var _list:Array = [];
		
		public function SubMenu()
		{
			var m:NativeMenu = NativeApplication.nativeApplication.menu;
			//var w:NativeMenu = NativeWindow
			
			var linkMenu:NativeMenu = new NativeMenu();
			m.addSubmenuAt(linkMenu,3,"Resource Links");
			//w.addSubmenuAt(linkMenu,3,"Resource Links");
			
			for(var item1:String in _listItems)
			{
				_list.push(item1);
			}
			_list.sort();
			for each(var item:String in _list)
			{
				var linkItem:NativeMenuItem = new NativeMenuItem(item);
				linkItem.addEventListener(Event.SELECT, onSelect);
				linkMenu.addItem(linkItem);
			}
		}
		private function onSelect(evt:Event):void
		{
			navigateToURL(new URLRequest(_listItems[evt.target.label]), "_blank");
			trace(_listItems[evt.target.label]);
		}
	}
}