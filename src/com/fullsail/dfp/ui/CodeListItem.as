package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.MouseEvent;
	
	import libs.CodeListItemBase;
	
	import mx.utils.StringUtil;
	
	public class CodeListItem extends CodeListItemBase
	{
		
		private var _codeVO:CodeVO;
		private var _isSelected:Boolean = false;
		
		public function CodeListItem()
		{
			super();
			
			mc_listbg.stop();
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			
			buttonMode = true;
			mouseChildren = false;
		}
		
		protected function onOver(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			mc_listbg.gotoAndStop("over");
			addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		protected function onOut(event:MouseEvent):void
		{
			if(!_isSelected)
			{
				//only resetting the state if it's not selected
				removeEventListener(MouseEvent.MOUSE_OUT,onOut);
				mc_listbg.gotoAndStop("normal");
				addEventListener(MouseEvent.MOUSE_OVER,onOver);
			}
			
		}
		
		public function get codeVO():CodeVO
		{
			return _codeVO;
		}

		public function set codeVO(value:CodeVO):void
		{
			_codeVO = value;
			createItemData();
		}
		
		private function createItemData():void
		{
			tfName.text = _codeVO.name;
			tfCourse.text = _codeVO.course.toUpperCase(); 
			//course abbreviation in all caps
			tfDifficulty.text = "Difficulty: " + _codeVO.difficulty;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			if(_isSelected)
			{
				mc_listbg.gotoAndStop("over");
			}else{
				mc_listbg.gotoAndStop("normal");
			}
		}

		
	}
}