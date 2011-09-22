package com.fullsail.dfp.ui
{
	import flash.events.Event;
	
	import libs.AboutPageBase;
	
	public class AboutPage extends AboutPageBase
	{
		
		private var speedY:Number = 0.5;
		
		public function AboutPage()
		{
			super();
			creditsWindow.addChild(mc_credits);
			mc_credits.y = 280;
			mc_credits.x = mc_credits.width / 4;
			
			addEventListener(Event.ENTER_FRAME,onCreditsAnimate);
		}
		
		protected function onCreditsAnimate(event:Event):void
		{
			mc_credits.y += -speedY;
			
			if(mc_credits.y < 0 - mc_credits.height)
			{
				mc_credits.y = 280;
			}
		}
	}
}