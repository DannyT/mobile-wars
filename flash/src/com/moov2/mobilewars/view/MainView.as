package com.moov2.mobilewars.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class MainView extends Sprite
	{
		private static const BOMB_COUNT:int = 4;
		private static const MAX_TIMER:int = 10;
		
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
			createMainView();
		}
		
		private function createBombs():void
		{
			var bombView:BombView;
			for(var i:int = 0; i< BOMB_COUNT; i++)
			{
				this._bombs.push(MAX_TIMER);
				bombView = new BombView();
				bombView.countDown = this._bombs[i];
				bombView.y = bombView.height * this._bombViews.length;
				this._bombViews.push(bombView);
				this.addChild(bombView);
			}
		}
		
		private function createMainView() : void
		{
			
		}
		
		public function setTime(timeUpdate:Number):void
		{
			if((timeUpdate - this._lastTime) > 1000) // is difference greater than 1000?
			{
				for(var i:int = 0; i < BOMB_COUNT; i++)
				{
					this._bombs[i]--;
					BombView(this._bombViews[i]).countDown = this._bombs[i]; 
				}
			   this._lastTime = timeUpdate;
			}
		}
	}
}