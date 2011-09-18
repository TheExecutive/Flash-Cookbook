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
	import flash.events.MouseEvent;
	
	import libs.ClassBtn;
	
	[SWF(width="800", height="680", frameRate="60")]
	public class FlashCookbook extends Sprite
	{
		
		//DigiBox Design 2011. All rights reserved.
		//REMINDER: Commit all major changes to any class files.
		
			/* ---------TO DO LIST-----------
				Add search functionality
				XML
				Minor design additions (animations, shading, etc)
			*/
		
			/* ---------COMPLETED (as of Sat morning)------
				Added functionality to class buttons
				List Item expansion
				List Item styling
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
			cntrls.scaleX = cntrls.scaleY = 0.7;
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
			createButtons();
			
			//init basebar
			
			//load in initial data
			loadInitialData();
		}
		
		private function loadInitialData():void
		{
			//this data loads in when the program first opens
			
			var xmlService:XMLService = new XMLService();
			xmlService.search();
			
			//listeners for the XMLService
			xmlService.addEventListener(XMLEvent.DATA_LOAD_COMPLETE,onDataComplete);
			xmlService.addEventListener(ErrorEvent.LOAD_ERROR,onDataError);
		}
		
		private function createButtons():void
		{
			var ffm:ClassButton = new ClassButton();
			ffm.label = "FFM";
			
			var oop:ClassButton = new ClassButton();
			oop.label = "OOP";
			
			var fat:ClassButton = new ClassButton();
			fat.label = "FAT";
			
			var dfp:ClassButton = new ClassButton();
			dfp.label = "DFP"; 
			
			_buttonArray = [ffm, oop, fat, dfp];
			
			//init layout box + add buttons to lb + add lb to stage
			var lb:LayoutBoxFSC = new LayoutBoxFSC(5,true);
			addChild(lb);
			lb.x = 127;
			lb.y = 68;
			lb.addEventListener(MouseEvent.CLICK,onButtonClick);
			//a single listener on the layoutbox, listening for all buttons.
			//saving memory for the win
			
			for each (var cb:ClassButton in _buttonArray)
			{
				var rm:RollOverManagerFSC = new RollOverManagerFSC(cb);
				lb.addChild(cb);
			}
			
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			var clickedButton:ClassButton = ClassButton(event.target);
			trace("clicked: " + clickedButton.label);
			
			for each (var cb:ClassBtn in _buttonArray)
			{
				cb.isSelected = (event.target == cb);  
				//this is a shorthand if statement, it's asking if the button clicked on 
				//is the currentTarget
				// event.currentTarget == cb will ONLY be true for the button clicked on
				// and it will set all other buttons to false.
				
				
			}
			var currentClass:String = event.target.label;
			_cListView.currentlyViewing = currentClass; 
			//assigning the label of the button clicked 
			//on as the currentlyViewing value in the setter
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