package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class BombView extends Sprite
	{
		public var usernameText : TextField;
		public var countDownText : TextField;
		
		public function set bomb(value:BombVO):void
		{
			this.usernameText.text = value.user;
			var timeLeft:int = value.timer <= 0 ? 0 : value.timer;
			this.countDownText.text = timeLeft < 10 ? "0" + timeLeft.toString() : timeLeft.toString() ;
		}
		
		public function BombView()
		{
			super();
		}
	}
}