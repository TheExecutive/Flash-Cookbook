package com.fullsail.dfp.ui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RollOverManagerFSC
	{
		private var _mc:MovieClip;
		private var _dir:int = -1;
		
		public function RollOverManagerFSC(mc:MovieClip)
		{
			_mc = mc; //whatever gets passed in is now mc
			_mc.stop();
			
			_mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		protected function onEnterFrame(event:Event):void
		{
			_mc.gotoAndStop(_mc.currentFrame + _dir);
			
			//continually doing this, making it advance forward or
			//backward
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			_dir = -1;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			_dir = 1;
		}
	}
}