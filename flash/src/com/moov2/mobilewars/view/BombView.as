package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.event.BombEvent;
	import com.moov2.mobilewars.vo.BombVO;
	
	import fl.motion.Color;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	public class BombView extends Sprite
	{
		private var _bomb : BombVO;
		private var _bombTapCallback : Function;
		public var usernameText : TextField;
		public var countDownText : TextField;
		
		public function set bomb(value:BombVO):void
		{
			this._bomb = value;
			this.usernameText.text = value.user;
			var timeLeft:int = value.timer <= 0 ? 0 : value.timer;
			this.countDownText.text = timeLeft < 10 ? "0" + timeLeft.toString() : timeLeft.toString() ;
			(timeLeft == 0) ? exploded() : normal();
		}
		
		public function BombView(bombTapCallback:Function)
		{
			this.mouseChildren = false;
			this._bombTapCallback = bombTapCallback;
			this.addEventListener(MouseEvent.CLICK, onClick);
			super();
		}
		
		private function onClick(e:MouseEvent):void
		{
			this._bombTapCallback(this._bomb);
		}
		
		private function normal():void
		{
			this.transform.colorTransform = new ColorTransform();
		}
		
		private function exploded():void
		{
			var c:Color=new Color();  
			c.setTint(0xff0000, 0.8);
			this.transform.colorTransform=c;
		}
	}
}