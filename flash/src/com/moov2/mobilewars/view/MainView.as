package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MainView extends Sprite
	{
		private static const BOMB_COUNT:int = 4;
		private static const MAX_TIMER:int = 20;
		private static const MIN_TIMER:int = 5;
		
		private var _bombs : Array;
		private var _bombViews : Array;
		private var _lastTime : Number;
		
		public function MainView()
		{
			super();
			this._lastTime = 0;
			this._bombs = [];
			this._bombViews = [];
			createBombs();
			createBombViews();
		}
		
		private function createBombs():void
		{
			// TODO: extract to service
			for(var i:int = 0; i< BOMB_COUNT; i++)
			{
				this._bombs.push(new BombVO("", "DannyT", getRandomTimer()));
			}
		}
		
		private function getRandomTimer():int
		{
			return (Math.floor(Math.random() * MAX_TIMER) + MIN_TIMER);	
		}
		
		private function createBombViews() : void
		{
			var bombView:BombView;
			for(var i:int = 0; i < this._bombs.length; i++)
			{
				bombView = new BombView();
				bombView.y = bombView.height * this._bombViews.length;
				bombView.addEventListener(MouseEvent.CLICK, onBombClick);
				this._bombViews.push(bombView);
				this.addChild(bombView);
			}
			updateBombs();
		}
		
		private function onBombClick(e:MouseEvent):void
		{
			
		}
		
		public function setTime(timeUpdate:Number):void
		{
			if((timeUpdate - this._lastTime) > 1000) // is difference greater than 1 second?
			{
				updateBombs();
			   	this._lastTime = timeUpdate;
			}
		}
		
		private function updateBombs():void
		{
			var bomb:BombVO;
			for(var i:int = 0; i < this._bombs.length; i++)
			{
				bomb = this._bombs[i];
				bomb.timer --;
				BombView(this._bombViews[i]).bomb = bomb; 
			}
		}
	}
}