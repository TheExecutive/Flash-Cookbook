package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.ErrorEvent;
	import com.fullsail.dfp.events.SearchEvent;
	import com.fullsail.dfp.filters.SearchFilter;
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import libs.CodeListViewBase;
	
	public class CodeListView extends CodeListViewBase
	{
		private var _loadedSnippets:Array;
		private var _codeItemListArray:Array;
		private var _removeThisIndex:int;
		
		private var _currentlyViewing:String = "";
		private var _currentSearch:String;
		private var _isSearching:Boolean = false;
		
		private var _lb:LayoutBoxFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this layout box
		//and the layout box in reusable code.
		
		private var _sm:SliderManagerFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this slider manager
		//and the manager in reusable code.
		
		private var _rangeOfMotion:Number;

		private var _itemFieldHeight:Number;
		private var _listFieldOpen:Boolean = false;

		private var _searchInd:Basebar;
		
		public function CodeListView()
		{
			super();
			slider.knob.buttonMode = true;
			
			setUpSliderManager();
			
			_codeItemListArray = []; //empty array to start.
			
			addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			if(_lb)
			{
				trace(_sm.pct);
				if(_sm.pct >= 0 && _sm.pct <= 1)
				{
					var delta:Number = _sm.pct + (-event.delta / 100);
					trace(delta)
					if(delta > 1)
					{
						_sm.pct = 1
					}else if(delta < 0){
						_sm.pct = 0
					}else{
						_sm.pct = delta
					}
					
					_lb.y = _sm.pct * -(_rangeOfMotion + 10 - listView.height);
				}else{
					_sm.pct = Math.round(_sm.pct);
				}
				
			}else{
				_sm.pct = 0; //if not, don't let the handle move
			}
			
		}
		
		private function setUpSliderManager():void
		{
			_sm = new SliderManagerFSC();
			_sm.addEventListener(Event.CHANGE,onScroll);
			_sm.setUpAssets(slider.track, slider.knob);
			_sm.pct = 0;
			
		}
		
		protected function onScroll(event:Event):void
		{
			if(_lb) //if the layoutbox is on the page
			{
				var pct:Number = _sm.pct;
				_lb.y = pct * -(_rangeOfMotion + 10 - listView.height);
				
				// the total height of the content minus the height of the result
				// view tells the content where to stop scrolling
			}else{
				_sm.pct = 0; //if not, don't let the handle move
			}
		}
		public function get isSearching():Boolean
		{
			return _isSearching;
		}
		
		public function set isSearching(value:Boolean):void
		{
			_isSearching = value;
		}
		public function get loadedSnippets():Array
		{
			return _loadedSnippets;
		}
		public function set loadedSnippets(value:Array):void
		{
			_loadedSnippets = value;
			clearListFieldsFromLB();
			//updateResultList(); //this is causing it to run twice on startup
		}
		public function get currentSearch():String
		{
			return _currentSearch;
		}
		public function set currentSearch(value:String):void
		{
			_currentSearch = value;
			clearListFieldsFromLB();
			//updateResultList(); //this is causing it to run twice
		}
		public function get currentlyViewing():String
		{
			return _currentlyViewing;
		}
		public function set currentlyViewing(value:String):void
		{
			_currentlyViewing = value;
			clearListFieldsFromLB();
			updateResultList(); //this is what starts everything going
		}
		private function updateResultList():void
		{
			// This function will create list items upon getting
			// a search result array full of VOs
			
			//resetting slider bar
			_sm.pct = 0;
			
			//if an old code item list is on the
			//stage, remove it
			var popListItem:CodeListItem;
			while(popListItem = _codeItemListArray.pop())
			{
				_lb.removeChild(popListItem);
				// as long as it is able to pop items
				// pop them off of the layout box
			}
			
			//the below is a tester for loop to test the position
			//of list items, the final version will use a for each loop
			
			_lb = new LayoutBoxFSC(2);
			//creating a new layout box with 2px of padding
			listViewWindow.addChild(_lb);
			_lb.x = 5;
			_lb.y = 10;
			//_lb.addEventListener(MouseEvent.CLICK,onItemClick);
			// ONE listener, listening for all items to be clicked.
			
			_codeItemListArray = [];
			//on subsequent runs, make the array empty
			//and repopulate it.
			
			
			//filtering the loadedSnippets into their respective arrays
			var searchArr:Array = _loadedSnippets.filter(SearchFilter["is" + _currentlyViewing ]);
			/* this will take the static functions in SearchFilter and add the currently viewing
			string (label of the buttons) to the end. All of the statics in the SearchFilter
			class begin with "is" and this will determine which function runs based on 
			the label in the button clicked. This saves me from having to make five if statements
			to determine which one is used. */
			
			if(_isSearching)
			{
				//if you are searching, filter the search results by the query
				//if not, ignore this
				searchArr = SearchFilter.searchFor(_currentSearch,searchArr);
			}
			
			
			
			for each(var cVO:CodeVO in searchArr)
			{
				var listItem:CodeListItem = new CodeListItem();
			
				//pushing the vo into the vo setter for the code list item
				listItem.codeVO = cVO;
				
				//adding it to the layout box
				_lb.addChild(listItem);
				
				//setting up a listener and pushing into array
				listItem.addEventListener(MouseEvent.CLICK,onItemClick); 
				//commented out because it turns out I can use just one listener
				_codeItemListArray.push(listItem);
			}
			
			//updateScrolling data after list has been populated
			updateScrollingData();
			
			var sEvent:SearchEvent = new SearchEvent(SearchEvent.UPDATE_NOTIFICATIONS);
			sEvent.listArray = searchArr;
			sEvent.query = _currentSearch;
			sEvent.isSearching = _isSearching;
			dispatchEvent(sEvent);
			
			trace("LENGTH: " + searchArr.length);
			
			//handling errors - if there is nothing in the array
			if(searchArr.length < 1)
			{
				var eEvent:ErrorEvent = new ErrorEvent(ErrorEvent.GENERAL_ERROR);
				eEvent.searchedQuery = _currentSearch;
				dispatchEvent(eEvent);
			}
		}
		
		protected function onItemClick(event:MouseEvent):void
		{
			for each(var listItem:CodeListItem in _codeItemListArray)
			{
				listItem.isSelected = (event.currentTarget == listItem); 
				//this is commented out because I am experimenting with having only one listener
				//that listens for all the clicks.
				
				//listItem.isSelected = (event.target == listItem);
				//again, this will make the one clicked true and 
				//all the others false. Only one can be active at a time.
				
				if(listItem.isSelected) //if isSelected is true
				{
					if(_removeThisIndex && _removeThisIndex > 0) 
					{
						//if removeThisIndex has a value and if it's greater than 0
						_lb.removeChildAt(_removeThisIndex);
						_listFieldOpen = false;
						
					}
					var itemIndex:int = _codeItemListArray.indexOf(listItem);
					
					var cItemField:CodeItemField = new CodeItemField();
					cItemField.cVO = listItem.codeVO;
					
					//saving the index of the item clicked, plus 1, meaning the codebox that's open
					
					_removeThisIndex = itemIndex + 1;
					
					//saving height of the itemField so the scrolling data can be updated
					_itemFieldHeight = cItemField.height;
					
					_lb.addChildAt(cItemField, itemIndex + 1);
					_listFieldOpen = true;
					
					//after an ItemField has been opened, update scrolling
					updateScrollingData();
					
				}
			}
		}
		private function updateScrollingData():void
		{
			
			//update scrolling data
			//calculationg height of the box
			_rangeOfMotion = 0;
			
			for each(var item:CodeListItem in _codeItemListArray)
			{
				_rangeOfMotion += (item.height + 2);
				// +2 is for the padding in the layout box
			}
			if(_listFieldOpen)
			{
				_rangeOfMotion += _itemFieldHeight + 2;
				//tacking on the itemfieldheight, but only 
				//if there is an itemfield open
			}
			
		}
		private function clearListFieldsFromLB():void
		{
			//a quick and dirty error sidesteppin' function, 
			//courtesy of your friendly, neighborhood Troy
			trace(_codeItemListArray.length);
			if(_listFieldOpen)
			{
				if(_removeThisIndex && _removeThisIndex > 0) 
				{
					//if removeThisIndex has a value and if it's greater than 0
					_lb.removeChildAt(_removeThisIndex);
					_listFieldOpen = false;
				}
			}
			_removeThisIndex = 0; //this stops the error of the index being wrong
			//resetting the index
			
		}
	}
}