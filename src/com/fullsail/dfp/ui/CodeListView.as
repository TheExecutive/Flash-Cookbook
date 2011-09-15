package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.Event;
	
	import libs.CodeListViewBase;
	
	public class CodeListView extends CodeListViewBase
	{
		private var _searchResults:Array;
		private var _codeItemListArray:Array;
		
		private var _lb:LayoutBoxFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this layout box
		//and the layout box in reusable code.
		
		private var _sm:SliderManagerFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this slider manager
		//and the manager in reusable code.
		
		private var _rangeOfMotion:Number;
		
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
				//creating a code list tem for each cVO passed in
				var listItem:CodeListItem = new CodeListItem();
				
				//pushing the vo into the vo setter for the code list item
				listItem.codeVO = cVO;
				
				//adding it to the layout box
				_lb.addChild(listItem);
				
				
				_codeItemListArray.push(listItem);
			}
			
			updateScrollingData();
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
			
			
		}
		
	}
}