package
{
	import com.fullsail.dfp.events.ErrorEvent;
	import com.fullsail.dfp.events.SearchEvent;
	import com.fullsail.dfp.events.XMLEvent;
	import com.fullsail.dfp.service.XMLService;
	import com.fullsail.dfp.ui.Background;
	import com.fullsail.dfp.ui.ChromeControls;
	import com.fullsail.dfp.ui.ClassButton;
	import com.fullsail.dfp.ui.CodeListView;
	import com.fullsail.dfp.ui.LayoutBoxFSC;
	import com.fullsail.dfp.ui.RollOverManagerFSC;
	import com.fullsail.dfp.ui.SearchBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import libs.ClassBtn;
	import libs.FSUlogo;
	import libs.NewSB;
	import libs.Newbtn;
	import libs.Title;
	
	[SWF(width="800", height="680", frameRate="60")]
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

		private var _cListView:CodeListView;
		private var _buttonArray:Array = [];
		
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
			_cListView = new CodeListView();
			addChild(_cListView);
			_cListView.x = (stage.stageWidth - _cListView.width) / 2;
			_cListView.y = bg.y + 96;
			
			/*var t:Title = new Title();
			t.x = 290;
			t.y = 11;       
			t.scaleX = t.scaleY = .8;            
			addChild(t);*/
			
			//init search
			var sb:SearchBox = new SearchBox();
			addChild(sb);
			sb.addEventListener(SearchEvent.SEARCH_QUERY,onSearch);
			
			//init buttons
			var ffm:ClassButton = new ClassButton();
			var ffmRoll:RollOverManagerFSC = new RollOverManagerFSC(ffm);
			ffm.label = "FFM";
			ffm.addEventListener(MouseEvent.CLICK,onFFMClick);
			_buttonArray.push(ffm);
			
			var oop:ClassButton = new ClassButton();
			var oopRoll:RollOverManagerFSC = new RollOverManagerFSC(oop);
			oop.label = "OOP";
			oop.addEventListener(MouseEvent.CLICK,onOOPClick);
			_buttonArray.push(oop);
			
			var fat:ClassButton = new ClassButton();
			var fatRoll:RollOverManagerFSC = new RollOverManagerFSC(fat);
			fat.label = "FAT";
			fat.addEventListener(MouseEvent.CLICK,onFATClick);
			_buttonArray.push(fat);
			
			var dfp:ClassButton = new ClassButton();
			var dfpRoll:RollOverManagerFSC = new RollOverManagerFSC(dfp);
			dfp.label = "DFP"; 
			dfp.addEventListener(MouseEvent.CLICK,onDFPClick);
			_buttonArray.push(dfp);
			
			//init layout box + add buttons to lb + add lb to stage
			var lb:LayoutBoxFSC = new LayoutBoxFSC(5,true);
			addChild(lb);
			lb.x = 127;
			lb.y = 68;
			
			for each (var cb:ClassButton in _buttonArray)
			{
				lb.addChild(cb);
			}
			
			//init basebar
		}
		
		protected function onFFMClick(event:MouseEvent):void
		{
			event.currentTarget.isSelected = true;
			/*for each (var cb:ClassButton in _buttonArray)
			{
				
			} */
		}
		
		protected function onOOPClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onFATClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onDFPClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onSearch(event:SearchEvent):void
		{
			// When the search button is clicked, this function runs
			
			var xmlService:XMLService = new XMLService();
			xmlService.search(event.query);
			//event.query is whatever is in the search box at the time 
			//the user hit the search button
			
			//listeners for the XMLService
			xmlService.addEventListener(XMLEvent.DATA_LOAD_COMPLETE,onDataComplete);
			xmlService.addEventListener(ErrorEvent.LOAD_ERROR,onDataError);
			
		}
		
		protected function onDataError(event:ErrorEvent):void
		{
			trace("Something's wrong with the XML");
		}
		
		protected function onDataComplete(event:XMLEvent):void
		{
			//after the data has finished loading and being parsed,
			//pass it to the setter in the codeListView
			_cListView.searchResults = event.codeVOArray;
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