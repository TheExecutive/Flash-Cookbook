package
{
	import com.fullsail.dfp.ui.Background;
	import com.fullsail.dfp.ui.ChromeControls;
	import com.fullsail.dfp.ui.ClassButton;
	import com.fullsail.dfp.ui.CodeListView;
	import com.fullsail.dfp.ui.LayoutBoxFSC;
	import com.fullsail.dfp.ui.SearchBox;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import libs.ClassBtn;
	import libs.FSUlogo;
	import libs.NewSB;
	import libs.Newbtn;
	import libs.Title;
	
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
			cntrls.x = bg.x + bg.width - cntrls.width - 12;
			cntrls.y = bg.y + 5;
			cntrls.closeButton.addEventListener(MouseEvent.CLICK,onCloseClick);
			cntrls.minimizeButton.addEventListener(MouseEvent.CLICK,onMinClick);
			
			//init list view
			var cListView:CodeListView = new CodeListView();
			addChild(cListView);
			cListView.x = (stage.stageWidth - cListView.width) / 2;
			cListView.y = bg.y + 96;
			
			//init logo
			var logo:FSUlogo = new FSUlogo();
			logo.x = 130;
			logo.y = 15;
			logo.buttonMode = true;
			addChild(logo); 
			
			/*var t:Title = new Title();
			t.x = 290;
			t.y = 11;       
			t.scaleX = t.scaleY = .8;            
			addChild(t);*/
			
			//init search
			var sb:SearchBox = new SearchBox();
			addChild(sb);
			
			//init buttons
			var ffm:ClassButton = new ClassButton();
			ffm.label = "FFM";
			var oop:ClassButton = new ClassButton();
			oop.label = "OOP";
			var fat:ClassButton = new ClassButton();
			fat.label = "FAT";
			var dfp:ClassButton = new ClassButton();
			dfp.label = "DFP";
			
			//init layout box + add buttons to lb + add lb to stage
			var lb:LayoutBoxFSC = new LayoutBoxFSC(2,true);
			lb.addChild(ffm);
			lb.addChild(oop);
			lb.addChild(fat);
			lb.addChild(dfp);
			lb.x = 127;
			lb.y = 68;
			addChild(lb);
			
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