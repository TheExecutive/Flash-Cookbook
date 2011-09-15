package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import libs.CodeListItemBase;
	
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
			tfTitle.text = _codeVO.name;
			tfCategory.text = _codeVO.course;
		}
		
	}
}