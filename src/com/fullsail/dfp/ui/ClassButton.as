package com.fullsail.dfp.ui
{
	import libs.ClassBtn;
	
	public class ClassButton extends ClassBtn
	{
		public function ClassButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.scaleX = this.scaleY = .75;
		}
	}
}