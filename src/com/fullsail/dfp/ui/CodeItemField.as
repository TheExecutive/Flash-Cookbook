package com.fullsail.dfp.ui
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;
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
			
			mc_codebg.width = tfCode.width + 5;
			
			//text in buttons
			mc_copy.tfListButton.text = "Copy";
			mc_pdf.tfListButton.text = "View PDF";
			
			//button mode
			mc_copy.buttonMode = true;
			mc_copy.mouseChildren = false;
			mc_pdf.buttonMode = true;
			mc_pdf.mouseChildren = false;
			
			//listeners
			mc_copy.addEventListener(MouseEvent.CLICK, onCopy);
			mc_pdf.addEventListener(MouseEvent.CLICK,onViewPDF);
		}
		
		protected function onViewPDF(event:MouseEvent):void
		{
			navigateToURL(new URLRequest(_cVO.resourcesLink), "_blank");
		}
		
		protected function onCopy(event:MouseEvent):void
		{
			tfCode.setSelection(0,tfCode.length);
			System.setClipboard(tfCode.text);
			mc_copy.tfListButton.text = "Copied!";
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
			if(_cVO.resourcesLink.indexOf("videos") != -1)
			{
				//if the resource link is to the videos
				//change button label to screencasts
				mc_pdf.tfListButton.text = "Screencasts";
				
			}
			else if(_cVO.resourcesLink == "" || _cVO.resourcesLink == "#")
			{
				//if there is no resource link in the XML, 
				//remove the button and listener
				mc_pdf.removeEventListener(MouseEvent.CLICK,onViewPDF);
				removeChild(mc_pdf);
			}
			
			
			tfCode.text = _cVO.codeString;
			tfNotes.text = _cVO.notes;
			
			//adding 10px of padding to every textfield
			tfCode.height = tfCode.height + 10;
			tfNotes.height = tfNotes.height + 10;
			
			//changing the x,y of the codebg to be dynamic according to
			//code textfield
			//mc_codebg.x = tfCode.x - 5;
			mc_codebg.y = tfCode.y - 5;
			mc_codebg.height = tfCode.height + 10;
			
			//changing the buttons to be positioned according to height of code window
			mc_copy.y = mc_codebg.y + mc_codebg.height + 5;
			mc_pdf.y = mc_copy.y;
			
			//correcting y position - the y of the notes will be
			//based on the code y and code height
			tfNotes.y = mc_copy.y + mc_copy.height + 10;
			//20px of padding between the notes and code
			
			fieldbaseBG.height = (tfCode.height + mc_copy.height + tfNotes.height) + 40;
			
			this.height = fieldbaseBG.height;
			
		}
		
	}
}