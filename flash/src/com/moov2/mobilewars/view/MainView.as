package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.event.BombEvent;
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	public class MainView extends Sprite
	{
		// TODO: extract config
		private static const BOMB_COUNT:int = 4;
		
		private var _bombTapCallback : Function;
		private var _bombs : Array;
		private var _bombViews : Array;
		private var _lastTime : Number;
		
		public function MainView(bombTapCallback:Function)
		{
			super();
			this._bombs = [];
			this._bombViews = [];
			this._bombTapCallback = bombTapCallback;
			createBombs();
			createBombViews();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function createBombs():void
		{
			// TODO: extract to service and pool bomb objects
			for(var i:int = 0; i< BOMB_COUNT; i++)
			{
				this._bombs.push(new BombVO("", "DannyT", Main.GetRandomTimer()));
			}
		}
		
		
		
		private function createBombViews() : void
		{
			var bombView:BombView;
			for(var i:int = 0; i < this._bombs.length; i++)
			{
				bombView = new BombView(this._bombTapCallback);
				bombView.y = bombView.height * this._bombViews.length;
				this._bombViews.push(bombView);
				this.addChild(bombView);
			}
			updateBombs();
		}
		
		private function addedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			var scale:Number = stage.stageWidth / this._bombViews[0].width;
			var bombView : BombView;

			for(var i:int = 0; i< this._bombViews.length; i++)
			{				
				bombView = BombView(this._bombViews[i]);
				bombView.y = (bombView.height * scale) * i;

				var tm:Matrix = new Matrix();
				tm.scale(scale, scale);
				tm.translate(bombView.x, bombView.y);
				bombView.transform.matrix = tm;
			}
		}
		
		public function timeTick():void
		{
			updateBombs();
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