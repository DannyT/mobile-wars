package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.event.BombEvent;
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class BombView extends Sprite
	{
		private var _bomb : BombVO;
		
		public var usernameText : TextField;
		public var countDownText : TextField;
		
		public function set bomb(value:BombVO):void
		{
			this._bomb = value;
			this.usernameText.text = value.user;
			var timeLeft:int = value.timer <= 0 ? 0 : value.timer;
			this.countDownText.text = timeLeft < 10 ? "0" + timeLeft.toString() : timeLeft.toString() ;
		}
		
		public function BombView()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			var bombEvent:BombEvent = new BombEvent(BombEvent.TAPPED);
			bombEvent.bomb = this._bomb;
			this.dispatchEvent(bombEvent);
		}
	}
}