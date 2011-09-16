package com.fullsail.dfp.events
{
	import com.fullsail.dfp.vo.CodeVO;
	
	import flash.events.Event;
	
	public class DetailEvent extends Event
	{
		public static const CODE_DETAIL:String = "DetailEvent.CODE_DETAIL";
		public var cVO:CodeVO;
		
		public function DetailEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			var de:DetailEvent = new DetailEvent(type, bubbles, cancelable);
			de.cVO = cVO;
			return de;
		}
	}
}