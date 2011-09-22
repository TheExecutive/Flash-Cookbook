package
{
	import air.update.ApplicationUpdaterUI;
	
	import com.fullsail.dfp.events.ErrorEvent;
	import com.fullsail.dfp.events.SearchEvent;
	import com.fullsail.dfp.events.XMLEvent;
	import com.fullsail.dfp.service.XMLService;
	import com.fullsail.dfp.ui.AboutPage;
	import com.fullsail.dfp.ui.Background;
	import com.fullsail.dfp.ui.Basebar;
	import com.fullsail.dfp.ui.ChromeControls;
	import com.fullsail.dfp.ui.ClassButton;
	import com.fullsail.dfp.ui.CodeListView;
	import com.fullsail.dfp.ui.ErrorModal;
	import com.fullsail.dfp.ui.LayoutBoxFSC;
	import com.fullsail.dfp.ui.RollOverManagerFSC;
	import com.fullsail.dfp.ui.SearchBox;
	import com.fullsail.dfp.ui.SubMenu;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import libs.ClassBtn;
	
	[SWF(width="620", height="700", frameRate="60")]
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
		
		private var _appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		private var _cListView:CodeListView;
		private var _buttonArray:Array = [];

		private var _baseBar:Basebar;
		private var _errorModal:ErrorModal = new ErrorModal();
		private var _aboutPage:AboutPage;

		private var _lb:LayoutBoxFSC;
		
		public function FlashCookbook()
		{
			//function to handle updates
			updater();
			
			initUI();
			
			//adds custom sub menu & items
			var sm:SubMenu = new SubMenu();
		}
		
		private function updater():void
		{
			_appUpdater.configurationFile = new File("app:/updateConfig.xml");
			_appUpdater.initialize();
			
			//the example xml path in the example xml file
			//<url>http://wddbs.com/dfp/activities/sampleupdate/updateDescriptor.xml</url> 
		}
		
		private function initUI():void
		{
			
			//initial position
			y = 15;
			
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
			cntrls.aboutButton.addEventListener(MouseEvent.CLICK,onAboutClick);
			
			//init list view
			_cListView = new CodeListView();
			addChild(_cListView);
			_cListView.x = (stage.stageWidth - _cListView.width) / 2;
			_cListView.y = bg.y + 96;
			_cListView.addEventListener(SearchEvent.RESET_TO_ALL,onReset);
			_cListView.addEventListener(SearchEvent.UPDATE_NOTIFICATIONS,onNotificationUpdate);
			_cListView.addEventListener(ErrorEvent.GENERAL_ERROR,launchError);
			
			//init search
			var sb:SearchBox = new SearchBox();
			addChild(sb);
			sb.addEventListener(SearchEvent.SEARCH_QUERY,onSearch);
			sb.x = (bg.x + bg.width) - sb.width - 30;
			sb.y = 35;
			
			//init buttons
			createButtons();
			
			//init basebar
			_baseBar = new Basebar();
			addChild(_baseBar);
			_baseBar.x = bg.x + 15;
			_baseBar.y = bg.height - 30;
			_baseBar.clearNotifications();
			
			//load in initial data
			loadInitialData();
		}
		
		protected function onReset(event:SearchEvent):void
		{
			resetToAll();
		}
		
		protected function onSearch(event:SearchEvent):void
		{
			
			_cListView.isSearching = true;
			_cListView.currentSearch = event.query;
			
			//On a new search, go back to ALL
			clearErrorPanel();
			resetToAll();
		}
		
		protected function onNotificationUpdate(event:SearchEvent):void
		{
			_baseBar.searchedFor = event.query;
			_baseBar.isSearching = event.isSearching;
			_baseBar.listArray = event.listArray;
			
		}
		
		private function loadInitialData():void
		{
			//this data loads in when the program first opens
			
			var xmlService:XMLService = new XMLService();
			xmlService.beginLoad();
			
			//loading
			_baseBar.textField = "Welcome to the Essential Flash Cookbook! Loading..."
			
			//listeners for the XMLService
			xmlService.addEventListener(XMLEvent.DATA_LOAD_COMPLETE,onDataComplete);
			xmlService.addEventListener(ErrorEvent.LOAD_ERROR,onDataError);
		}
		
		private function createButtons():void
		{
			var all:ClassButton = new ClassButton();
			all.label = "All";
			
			var ffm:ClassButton = new ClassButton();
			ffm.label = "FFM";
			
			var oop:ClassButton = new ClassButton();
			oop.label = "OOP";
			
			var fat:ClassButton = new ClassButton();
			fat.label = "FAT";
			
			var dfp:ClassButton = new ClassButton();
			dfp.label = "DFP"; 
			
			_buttonArray = [all, ffm, oop, fat, dfp];
			
			//init layout box + add buttons to lb + add lb to stage
			_lb = new LayoutBoxFSC(5,true);
			addChild(_lb);
			_lb.x = 38;
			_lb.y = 68;
			
			for each (var cb:ClassButton in _buttonArray)
			{
				var rm:RollOverManagerFSC = new RollOverManagerFSC(cb);
				_lb.addChild(cb);
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
			_cListView.isSearching = false;
			//if you click on a button, you're not searching
			_cListView.currentlyViewing = currentClass; 
			//assigning the label of the button clicked 
			//on as the currentlyViewing value in the setter
			
			
			clearErrorPanel();
		}
		
		protected function onDataError(event:ErrorEvent):void
		{
			trace("Something's wrong with the XML");
		}
		
		protected function onDataComplete(event:XMLEvent):void
		{
			_lb.addEventListener(MouseEvent.CLICK,onButtonClick);
			//a single listener on the layoutbox, listening for all buttons.
			//Not adding the listener to the buttons until the data has been loaded.
			
			//after the data has finished loading and being parsed,
			//pass it to the setter in the codeListView
			_cListView.loadedSnippets = event.codeVOArray;
			
			resetToAll();
		}
		
		protected function onAboutClick(event:MouseEvent):void
		{
			_aboutPage = new AboutPage();
			addChild(_aboutPage);
			_aboutPage.x = (stage.stageWidth - _aboutPage.width) / 2;
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
		private function resetToAll():void
		{
			//setting the All button as the default button on startup
			_cListView.currentlyViewing = "All"; //this will cause an error if the data hasn't been loaded in
			
			for each (var cb:ClassBtn in _buttonArray)
			{
				cb.isSelected = (cb.label == "All");  
				//turning the All button on and all others off
			}
			
		}
		private function launchError(event:ErrorEvent):void
		{
			_errorModal.searchedFor = event.searchedQuery;
			addChild(_errorModal);
			_errorModal.x = stage.stageWidth/2;
			_errorModal.y = stage.stageHeight/2;
			_errorModal.scaleX = _errorModal.scaleY = 0.5;
			TweenMax.to(_errorModal, 0.2, {scaleX:1, scaleY:1});
		}
		private function clearErrorPanel():void
		{
			if(_errorModal.stage)
			{
				removeChild(_errorModal);
			}
		}
	}
}