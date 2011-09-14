package com.fullsail.dfp.ui
{
	import libs.ChromeControlsBase;
	
	public class ChromeControls extends ChromeControlsBase
	{
		public function ChromeControls()
		{
			super();
			minimizeButton.buttonMode = true;
			minimizeButton.mouseChildren = false;
			
			closeButton.buttonMode = true;
			closeButton.mouseChildren = false;
		}
	}
}