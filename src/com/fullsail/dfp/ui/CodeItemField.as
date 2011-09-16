package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.text.TextFieldAutoSize;
	
	import libs.ItemFieldBase;
	
	public class CodeItemField extends ItemFieldBase
	{
		private var _cVO:CodeVO;
		
		public function CodeItemField()
		{
			super();
			tfKeywords.autoSize = TextFieldAutoSize.LEFT;
			tfKeywords.width = 502;
			tfCode.autoSize = TextFieldAutoSize.LEFT;
			tfCode.width = 502;
			tfNotes.autoSize = TextFieldAutoSize.LEFT;
			tfNotes.width = 502;
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
			tfKeywords.text = _cVO.keywords;
			tfCode.text = _cVO.codeString;
			tfNotes.text = _cVO.notes;
			
			fieldbaseBG.height = (tfKeywords.height + tfCode.height + tfNotes.height) + 10;
			
		}
		
	}
}