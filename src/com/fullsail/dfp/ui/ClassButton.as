package com.fullsail.dfp.ui
{
	import flash.filters.DropShadowFilter;
	
	import libs.ClassBtn;
	
	public class ClassButton extends ClassBtn
	{
		
		private var _label:String;
		private var _isSelected:Boolean = false;
		
		public function ClassButton()
		{
			super();
			stop();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.scaleX = this.scaleY = .75;
			
			var dropShadow:DropShadowFilter = new DropShadowFilter(2,45,0,0.9);
			filters = [dropShadow];
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
				btnRollover.gotoAndStop(30);
			}else{
				btnRollover.gotoAndStop(1);
			}
		}
		
	}
}