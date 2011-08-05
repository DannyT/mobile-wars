package com.moov2.mobilewars.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class BombView extends Sprite
	{
		public var usernameText : TextField;
		public var countDownText : TextField;
		
		public function set countDown(value:int):void
		{
			this.countDownText.text = value < 10 ? "0" + value.toString() : value.toString() ;
		}
		
		public function BombView()
		{
			super();
		}
	}
}