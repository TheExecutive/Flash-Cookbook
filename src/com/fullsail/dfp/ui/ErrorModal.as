package com.fullsail.dfp.ui
{
	import libs.ErrorModalBase;
	
	public class ErrorModal extends ErrorModalBase
	{
		
		private var _searchedFor:String;
		
		public function ErrorModal()
		{
			super();
			tfError1.text = "";
			tfError2.text = "";
		}

		public function set searchedFor(value:String):void
		{
			_searchedFor = value;
			showError();
		}
		
		private function showError():void
		{
			//random error handling
			var randomNumber:Number = Math.round(Math.random() * 3) + 1
			switch(randomNumber)
			{
				case 1:
					tfError1.text = "Failure is an option, apparently.";
					break;
				case 2:
					tfError1.text = "Nothing to see here.";
					break;
				case 3:
					tfError1.text = "...new ErrorEvent();";
					break;
				case 4:
					tfError1.text = "This isn't the code you're looking for.";
					break;
			}
			
			var randomNumberSmall:Number = Math.round(Math.random() * 7) + 1
			switch(randomNumberSmall)
			{
				case 1:
					tfError2.text = "We have no idea what that is. If you do, you're smarter than us. Good for you on that.";
					break;
				case 2:
					tfError2.text = "Never heard of that one. If it's something we should have, click Report Bug and let us know.";
					break;
				case 3:
					tfError2.text = "Don't think you spelled that right. But don't worry, you can try again, no charge. Aren't we nice?";
					break;
				case 4:
					tfError2.text = "I'm sure we speak the same language. You should try typing it better, however.";
					break;
				case 5:
					tfError2.text = "We don't think l337 speak is valid ActionScript 3.0. Try again.";
					break;
				case 6:
					tfError2.text = "Nothing to see here. Double check your search and try one more time.";
					break;
				case 7:
					tfError2.text = "No results. If it's our fault, click Report Bug below. If it's yours, then stop failing.";
					break;
				case 8:
					tfError2.text = "Zero results, but don't panic. Take a deep breath, think of cute kittens and try again.";
					break;
			}
		}
		
	}
}