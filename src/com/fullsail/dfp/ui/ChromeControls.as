package com.fullsail.dfp.ui
{
	import flash.events.MouseEvent;
	
	import libs.ChromeControlsBase;
	
	public class ChromeControls extends ChromeControlsBase
	{
		public function ChromeControls()
		{
			super();
			
			aboutButton.stop();
			aboutButton.buttonMode = true;
			aboutButton.mouseChildren = false;
			aboutButton.addEventListener(MouseEvent.MOUSE_OVER,onAboutOver);
			
			minimizeButton.stop();
			minimizeButton.buttonMode = true;
			minimizeButton.mouseChildren = false;
			minimizeButton.addEventListener(MouseEvent.MOUSE_OVER,onMinOver);
			
			closeButton.stop();
			closeButton.buttonMode = true;
			closeButton.mouseChildren = false;
			closeButton.addEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
			
		}
		
		protected function onAboutOver(event:MouseEvent):void
		{
			aboutButton.removeEventListener(MouseEvent.MOUSE_OVER,onAboutOver);
			aboutButton.gotoAndStop("over");
			aboutButton.addEventListener(MouseEvent.MOUSE_OUT,onAboutOut);
		}
		
		protected function onMinOver(event:MouseEvent):void
		{
			minimizeButton.removeEventListener(MouseEvent.MOUSE_OVER,onMinOver);
			minimizeButton.gotoAndStop("over");
			minimizeButton.addEventListener(MouseEvent.MOUSE_OUT,onMinOut);
		}
		protected function onCloseOver(event:MouseEvent):void
		{
			closeButton.removeEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
			closeButton.gotoAndStop("over");
			closeButton.addEventListener(MouseEvent.MOUSE_OUT,onCloseOut);
		}
		
		protected function onAboutOut(event:MouseEvent):void
		{
			aboutButton.removeEventListener(MouseEvent.MOUSE_OUT,onAboutOut);
			aboutButton.gotoAndStop("normal");
			aboutButton.addEventListener(MouseEvent.MOUSE_OVER,onAboutOver);
		}
		
		protected function onMinOut(event:MouseEvent):void
		{
			minimizeButton.removeEventListener(MouseEvent.MOUSE_OUT,onMinOut);
			minimizeButton.gotoAndStop("normal");
			minimizeButton.addEventListener(MouseEvent.MOUSE_OVER,onMinOver);
		}
		protected function onCloseOut(event:MouseEvent):void
		{
			closeButton.removeEventListener(MouseEvent.MOUSE_OUT,onCloseOut);
			closeButton.gotoAndStop("normal");
			closeButton.addEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
		}
	}
}