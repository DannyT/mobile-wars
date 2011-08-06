package
{
	import com.moov2.mobilewars.event.BombEvent;
	import com.moov2.mobilewars.view.MainView;
	import com.moov2.mobilewars.view.ReturnView;
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class Main extends Sprite
	{
		public static const MAX_TIMER:int = 20;
		public static const MIN_TIMER:int = 5;
		
		private var _mainView : MainView;
		private var _returnView : ReturnView;
		
		private var _secondsTimer : int;
		private var _gameLoop : Timer;
		
		private static const GAME_VIEW:int = 0;
		private static const RETURN_VIEW : int = 1;
		private var _currentView : int = GAME_VIEW;
		
		public static function GetRandomTimer():int
		{
			return (Math.floor(Math.random() * MAX_TIMER) + MIN_TIMER);	
		}
		
		public function Main()
		{
			setupGameLoop();
			createMainView();
			createReturnView();
			this._gameLoop.start();
		}
		
		private function setupGameLoop():void
		{
			this._secondsTimer = 0;
			this._gameLoop = new Timer(50);
			this._gameLoop.addEventListener(TimerEvent.TIMER, onGameUpdate);
		}
		
		private function createMainView():void
		{
			this._mainView = new MainView(onBombTap);
			this._mainView.addEventListener(BombEvent.TAPPED, onBombTap);
			this.addChild(_mainView);
		}
		
		private function createReturnView():void
		{
			this._returnView = new ReturnView( this.onBombReturn );
		}
		
		private function onGameUpdate(e:Event):void
		{
			var timeUpdate:int = getTimer();
			if ((timeUpdate - this._secondsTimer) >= 1000) // seconds
			{
				this._mainView.timeTick();
				if(this._currentView == RETURN_VIEW)
					this._returnView.timeTick();
				this._secondsTimer = timeUpdate;
			}
		}
		
		private function onBombTap(bomb:BombVO):void
		{
			// show throwback view
			this._returnView.bomb = bomb;
			this.addChild(this._returnView);
			this._currentView = RETURN_VIEW;
		}
		
		private function onBombReturn(bomb:BombVO):void
		{
			this.removeChild(this._returnView);
			this._currentView = GAME_VIEW;
			bomb.timer = GetRandomTimer();
			this._mainView.timeTick();
		}
	}
}