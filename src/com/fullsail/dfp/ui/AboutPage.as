package com.fullsail.dfp.ui
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import libs.AboutPageBase;
	
	public class AboutPage extends AboutPageBase
	{
		
		private var speedY:Number = 0.5;
		
		public function AboutPage()
		{
			super();
			
			closeAboutButton.stop();
			
			creditsWindow.addChild(mc_credits);
			mc_credits.y = 280;
			mc_credits.x = mc_credits.width / 4;
			
			addEventListener(Event.ENTER_FRAME,onCreditsAnimate);
			closeAboutButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			closeAboutButton.addEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
		}
		
		protected function onCloseOver(event:MouseEvent):void
		{
			closeAboutButton.removeEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
			closeAboutButton.gotoAndStop("over");
			closeAboutButton.addEventListener(MouseEvent.MOUSE_OUT,onCloseOut);
		}
		
		protected function onCloseOut(event:MouseEvent):void
		{
			closeAboutButton.removeEventListener(MouseEvent.MOUSE_OUT,onCloseOut);
			closeAboutButton.gotoAndStop("normal");
			closeAboutButton.addEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
		}
		
		protected function onCloseClick(event:MouseEvent):void
		{
			this.parent.removeChild(this);
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