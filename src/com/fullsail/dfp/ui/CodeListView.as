package com.fullsail.dfp.ui
{
	import flash.events.Event;
	
	import libs.CodeListViewBase;
	
	public class CodeListView extends CodeListViewBase
	{
		private var _searchResults:Array;
		
		private var _lb:LayoutBoxFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this layout box
		//and the layout box in reusable code.
		
		private var _sm:SliderManagerFSC;
		//FSC stands for full sail cookbook
		//just so there's no confusion between this slider manager
		//and the manager in reusable code.
		
		public function CodeListView()
		{
			super();
			slider.knob.buttonMode = true;
			
			setUpSliderManager();
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
			// TODO Auto-generated method stub
			trace("it's movin");
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
		}
		
	}
}