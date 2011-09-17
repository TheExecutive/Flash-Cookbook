package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.events.DetailEvent;
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import libs.CodeListViewBase;
	
	public class CodeListView extends CodeListViewBase
	{
		private var _searchResults:Array;
		private var _codeItemListArray:Array;
		private var _removeThisIndex:int;
		
		private var _currentlyViewing:String = "";
		
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
		
		public function CodeListView()
		{
			super();
			slider.knob.buttonMode = true;
			
			setUpSliderManager();
			
			_codeItemListArray = []; //empty array to start.
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

		public function get searchResults():Array
		{
			return _searchResults;
		}

		public function set searchResults(value:Array):void
		{
			_searchResults = value;
			clearListFieldsFromLB();
			updateResultList();
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
			
			_codeItemListArray = [];
			//on subsequent runs, make the array empty
			//and repopulate it.
			
			for each(var cVO:CodeVO in _searchResults)
			{
				if(_currentlyViewing == cVO.course.toUpperCase())
				{
					//creating a code list tem for each cVO passed in
					var listItem:CodeListItem = new CodeListItem();
					
					//pushing the vo into the vo setter for the code list item
					listItem.codeVO = cVO;
					
					//adding it to the layout box
					_lb.addChild(listItem);
					
					//setting up a listener and pushing into array
					listItem.addEventListener(MouseEvent.CLICK,onItemClick);
					_codeItemListArray.push(listItem);
					/*
					the reason I don't have just one listener on the layout box 
					instead is because we eventually plan to have the layoutbox 
					expand with content that will not be clickable, (indexOf) 
					and that will cause errors if those items are clicked. 
					This can possibly be fixed with IF statements. 
					Something to look into later.
					*/
				}else if(_currentlyViewing == "" || _currentlyViewing == "All")
				{
					//this should only run on the first load or if the 
					// all button is clicked
					var listItemAll:CodeListItem = new CodeListItem();
	
					listItemAll.codeVO = cVO;
					
					_lb.addChild(listItemAll);
					
					listItemAll.addEventListener(MouseEvent.CLICK,onItemClick);
					_codeItemListArray.push(listItemAll);
				}
				
				
			}
			//updateScrolling data after list has been populated
			updateScrollingData();
		}
		
		protected function onItemClick(event:MouseEvent):void
		{
			for each(var listItem:CodeListItem in _codeItemListArray)
			{
				listItem.isSelected = (event.currentTarget == listItem);
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
					
					//not sure if I need this event here yet
					//but it can't hurt
					var dEvent:DetailEvent = new DetailEvent(DetailEvent.CODE_DETAIL);
					dEvent.cVO = listItem.codeVO;
					dispatchEvent(dEvent);
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

		public function get currentlyViewing():String
		{
			return _currentlyViewing;
		}

		public function set currentlyViewing(value:String):void
		{
			_currentlyViewing = value;
			clearListFieldsFromLB();
			updateResultList();
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