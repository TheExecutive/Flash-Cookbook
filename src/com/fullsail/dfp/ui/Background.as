package com.fullsail.dfp.ui
{
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
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
			
			//var dropShadow:DropShadowFilter = new DropShadowFilter(36,92,0x000000,BitmapFilterQuality.MEDIUM,50,50,.35,1);
			//var glow:GlowFilter = new GlowFilter(0x000000,.3,80,35,.3,1);
			//filters = [dropShadow,glow];
		}
		
		protected function onLogoClick(event:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.fullsail.edu"), "_blank");
		}
	}
}