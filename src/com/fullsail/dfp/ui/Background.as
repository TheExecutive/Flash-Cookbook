package com.fullsail.dfp.ui
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import libs.BackgroundBase;
	import libs.FSUlogo;
	
	public class Background extends BackgroundBase
	{
		public function Background()
		{
			super();
			
			var logo:FSUlogo = new FSUlogo();
			logo.x = 20;
			logo.y = 15;
			logo.buttonMode = true;
			addChild(logo);
			logo.addEventListener(MouseEvent.CLICK,onLogoClick); 
		}
		
		protected function onLogoClick(event:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.fullsail.edu"), "_blank");
		}
	}
}