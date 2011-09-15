package
{
	import com.fullsail.dfp.ui.Background;
	import com.fullsail.dfp.ui.ChromeControls;
	import com.fullsail.dfp.ui.CodeListView;
	import com.fullsail.dfp.ui.SearchBox;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import libs.NewSB;
	import libs.Newbtn;
	
	[SWF(width="800", height="640", frameRate="60")]
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
			bg.x = (stage.stageWidth - bg.width) / 2;
			bg.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			//init page controls
			var cntrls:ChromeControls = new ChromeControls();
			addChild(cntrls);
			cntrls.scaleX = cntrls.scaleY = 0.6;
			cntrls.x = bg.x + bg.width - cntrls.width - 10;
			cntrls.y = bg.y + 5;
			cntrls.closeButton.addEventListener(MouseEvent.CLICK,onCloseClick);
			cntrls.minimizeButton.addEventListener(MouseEvent.CLICK,onMinClick);
			
			//init list view
			var cListView:CodeListView = new CodeListView();
			addChild(cListView);
			cListView.x = (stage.stageWidth - cListView.width) / 2;
			cListView.y = bg.y + 96;
			
			
			//init search
			var sb:SearchBox = new SearchBox();
			addChild(sb);
			
			//init buttons
			
			//init basebar
		}
		
		protected function onCloseClick(event:MouseEvent):void
		{
			stage.nativeWindow.close(); // this closes the window
		}
		protected function onMouseDown(event:MouseEvent):void
		{
			stage.nativeWindow.startMove();
		}
		protected function onMinClick(event:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
		
		
	}
}