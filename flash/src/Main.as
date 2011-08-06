package
{
	import com.moov2.mobilewars.event.BombEvent;
	import com.moov2.mobilewars.view.MainView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import com.moov2.mobilewars.view.ReturnView;
	
	public class Main extends Sprite
	{
		private var _mainView : MainView;
		private var _returnView : ReturnView;
		
		private var _gameLoop : Timer; 
		
		public function Main()
		{
			setupGameLoop();
			createMainView();
			createReturnView();
			this._gameLoop.start();
		}
		
		private function setupGameLoop():void
		{
			this._gameLoop = new Timer(50);
			this._gameLoop.addEventListener(TimerEvent.TIMER, onGameUpdate);
		}
		
		private function createMainView():void
		{
			this._mainView = new MainView();
			this._mainView.addEventListener(BombEvent.TAPPED, onBombTap);
			this.addChild(_mainView);
		}
		
		private function createReturnView():void
		{
			this._returnView = new ReturnView();
			
		}
		
		private function onGameUpdate(e:Event):void
		{
			// update stuff	
			this._mainView.setTime(getTimer());
		}
		
		private function onBombTap(e:BombEvent):void
		{
			// show throwback view
			this._returnView.bomb = e.bomb;
			this.addChild(this._returnView);
			
		}
	}
}