package com.fullsail.dfp.ui
{
	import flash.events.MouseEvent;
	
	import libs.ChromeControlsBase;
	
	public class ChromeControls extends ChromeControlsBase
	{
		public function ChromeControls()
		{
			super();
			
			minimizeButton.stop();
			minimizeButton.buttonMode = true;
			minimizeButton.mouseChildren = false;
			minimizeButton.addEventListener(MouseEvent.MOUSE_OVER,onMinOver);
			
			closeButton.stop();
			closeButton.buttonMode = true;
			closeButton.mouseChildren = false;
			closeButton.addEventListener(MouseEvent.MOUSE_OVER,onCloseOver);
			
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