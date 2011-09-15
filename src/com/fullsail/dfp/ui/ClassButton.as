package com.fullsail.dfp.ui
{
	import libs.ClassBtn;
	
	public class ClassButton extends ClassBtn
	{
		
		private var _label:String;
		
		public function ClassButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.scaleX = this.scaleY = .75;
		}

		public function set label(value:String):void
		{
			_label = value;
			tfClassName.text = _label;
		}

	}
}