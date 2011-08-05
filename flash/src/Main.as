package
{
	import com.moov2.mobilewars.view.MainView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class Main extends Sprite
	{
		private var _mainView : MainView;
		
		private var _gameLoop : Timer; 
		
		public function Main()
		{
			this._gameLoop = new Timer(50);
			this._gameLoop.addEventListener(TimerEvent.TIMER, onGameUpdate);
			this._mainView = new MainView();
			this.addChild(_mainView);
			this._gameLoop.start();
		}
		
		private function onGameUpdate(e:Event):void
		{
			// update stuff	
			this._mainView.setTime(getTimer());
		}
	}
}