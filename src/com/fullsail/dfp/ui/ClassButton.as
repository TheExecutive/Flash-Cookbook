package com.fullsail.dfp.ui
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	import libs.ClassBtn;
	
	public class ClassButton extends ClassBtn
	{
		private var _label:String;
		private var _isSelected:Boolean = false; //default is false

		private var _selectedGlow:GlowFilter;

		private var _dropShadow:DropShadowFilter;
		
		public function ClassButton()
		{
			super();
			stop();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.scaleX = this.scaleY = .75;
			
			_dropShadow = new DropShadowFilter(2,45,0,0.9);
			filters = [_dropShadow];
			
			_selectedGlow = new GlowFilter(0xa94000,1);
			//setting up glow
		}
		
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			_label = value;
			tfClassName.text = _label;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			updateButtonState();
		}
		
		private function updateButtonState():void
		{
			if(_isSelected)
			{
				filters = [_dropShadow, _selectedGlow];
				alpha = 1;
			}else{
				filters = [_dropShadow];
				alpha = 0.7;
			}
		}

		
	}
}