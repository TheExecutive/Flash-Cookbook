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
			tfCode.text = _cVO.codeString;
			tfNotes.text = _cVO.notes;
			
			//adding 10px of padding to every textfield
			tfCode.height = tfCode.height + 10;
			tfNotes.height = tfNotes.height + 10;
			
			//correcting y position - the y of the notes will be
			//based on the code y and code height
			tfNotes.y = tfCode.y + tfCode.height;
			
			fieldbaseBG.height = (tfCode.height + tfNotes.height) + 20;
			
			this.height = fieldbaseBG.height;
			
		}
		
	}
}