package com.fullsail.dfp.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class LayoutBoxFSC extends Sprite
	{
		
		private var _children:Array;
		private var _padding:int;
		private var _isHorizontal:Boolean;
		
		public function LayoutBoxFSC(padding:int = 10, isHorizontal:Boolean = false) 
		//if there is no value passed to padding, set padding equal to 10
		{
			super();
			_padding = padding; // taking the value that's passed 
			//in and setting it to the padding var
			_isHorizontal = isHorizontal; //the one without the 
			//underscore is referring to what's getting passed 
			//in as default at the top
			_children = []; //is equal to an empty array
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			_children.push(child);
			
			updateUI();
			
			return child; // you could say return super.addChild(child) here and not need
			// the super.addChild(child) at the top
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var index:int = _children.indexOf(child); 
			//getting the number of where this chosen child is in the _children array
			
			_children.splice(index, 1);
			// removing the element from the array at that position specified, and removing only 1.
			
			updateUI();
			
			return super.removeChild(child);
		}
		private function updateUI():void
		{
			var pos:int = 0;
			
			for each(var child:DisplayObject in _children)
			{
				
				if(_isHorizontal)
				{
					//if this is horizontal
					child.y = 0; //resetting the position
					child.x = pos;
					pos += child.width + this.padding;
				}else{
					//if this is vertical
					child.x = 0; // resetting the position
					child.y = pos;
					pos += child.height + this.padding;
				}
			}
		
		}

		public function get padding():int
		{
			return _padding;
		}

		public function set padding(value:int):void
		{
			_padding = value;
			updateUI();
		}

		public function get isHorizontal():Boolean
		{
			return _isHorizontal;
		}

		public function set isHorizontal(value:Boolean):void
		{
			_isHorizontal = value;
		}


	}
}