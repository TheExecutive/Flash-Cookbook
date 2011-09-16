package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import libs.ItemFieldBase;
	
	public class CodeItemField extends ItemFieldBase
	{
		
		private var _cVO:CodeVO;
		
		public function CodeItemField()
		{
			super();
		}

		public function get cVO():CodeVO
		{
			return _cVO;
		}

		public function set cVO(value:CodeVO):void
		{
			_cVO = value;
			updateItemField();
		}
		
		private function updateItemField():void
		{
			tfFieldText.text = _cVO.codeString + "\n\n" + _cVO.notes;
		}
		
	}
}