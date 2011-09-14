package com.fullsail.dfp.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class SliderManagerFSC extends EventDispatcher
	{
		private var _track:Sprite;
		private var _handle:Sprite;
		private var _pct:Number;
		
		public function SliderManagerFSC()
		{
			
		}
		public function setUpAssets(track:Sprite, handle:Sprite):void
		{
			_track = track;
			_handle = handle;
			
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			_handle.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_handle.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_handle.stopDrag();
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(0, 0, _track.width - _handle.width, 0); 
			//this is not the rectangle made by me, this is flash's rectangle
			//this keeps the slider handle in place
			
			_handle.startDrag(false, rect);
			
			_handle.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			_handle.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp); 
			//listen for the mouse up anywhere on the stage.
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			_pct = _handle.x / (_track.width - _handle.width);
			if(_pct > 0.99)
			{
				_pct = 1; 
				// this is only for if the track's length is a 
				// non whole number, like 124.50 instead of 124
			}
			
			dispatchEvent(new Event(Event.CHANGE)); 
			// this is so the class you're using this with can 
			// know the slider value changed
		}
		
		public function get pct():Number
		{
			return _pct;
		}
		
		public function set pct(value:Number):void
		{
			_pct = value;
			_handle.x = _pct * (_track.width - _handle.width); 
			// so the handle goes to wherever the percent is on default
		}
		
	}
}