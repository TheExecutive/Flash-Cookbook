package
{
	import com.fullsail.dfp.ui.Background;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="800", height="800", frameRate="60")]
	public class FlashCookbook extends Sprite
	{
		
		//DigiBox Design 2011. All rights reserved.
		//REMINDER: Commit all major changes to any class files.
		
			/* ---------TO DO LIST-----------
				Build Base Class Structure (comments)
			*/
		
			/* ---------COMPLETED (as of Wed morning)------
				Created libs folder
				Merged in assets FLA
				Set up custom chrome basics
				Set stage dimensions
			*/
		
		public function FlashCookbook()
		{
			initUI();
		}
		
		private function initUI():void
		{
			//init background
			var bg:Background = new Background();
			addChild(bg);
			bg.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			//init main view
			
			//init search
			
			//init buttons
			
			//init basebar
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			//testing move function
			stage.nativeWindow.startMove();
		}
		
		
		
	}
}