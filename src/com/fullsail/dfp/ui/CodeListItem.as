package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import libs.CodeListItemBase;
	
	import mx.utils.StringUtil;
	
	public class CodeListItem extends CodeListItemBase
	{
		
		private var _codeVO:CodeVO;
		
		public function CodeListItem()
		{
			super();
			buttonMode = true;
			mouseChildren = false;
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
		
	}
}