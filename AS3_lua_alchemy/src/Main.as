package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import luaAlchemy.LuaAlchemy;
	
	/**
	 * ...
	 * @author Alexander Alexeychuk
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			_game = new GuesGame();
			
			var textLabel:TextField;
			
			// games buttons
			for (var i:int = 0; i < 10; ++i)
			{
				var btnGame:Sprite = new Sprite();
				textLabel = new TextField();
				btnGame.graphics.clear();
				btnGame.graphics.beginFill(0xD4D4D4); // grey color
				btnGame.graphics.drawRoundRect(0, 0, 24, 24, 5, 5); // x, y, width, height, ellipseW, ellipseH
				btnGame.graphics.endFill();
				textLabel.text = '' + (i + 1);
				textLabel.x = 5;
				textLabel.y = 3;
				textLabel.selectable = false;
				btnGame.addChild(textLabel)
				btnGame.x = i * 25;
				btnGame.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent):void {
					//trace(e.currentTarget);
					trace(e.currentTarget.x / 25);
					_clickButton(e.currentTarget.x / 25);
				}, true, 0, false);
				addChild(btnGame);
			}

			var btnStart:Sprite = new Sprite();
			textLabel = new TextField();
			btnStart.graphics.clear();
			btnStart.graphics.beginFill(0xD4D4D4);
			btnStart.graphics.drawRoundRect(0, 0, 50, 24, 5, 5);
			btnStart.graphics.endFill();
			textLabel.text = 'Start';
			textLabel.x = 5;
			textLabel.y = 3;
			textLabel.selectable = false;
			btnStart.addChild(textLabel)
			btnStart.y = 50;
			btnStart.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent):void {
				_start();
			}, true, 0, false);
			addChild(btnStart);
			
			_lblGame = new TextField();
			_lblGame.width = 400;
			_lblGame.x = 70;
			_lblGame.y = 50;
			_lblGame.selectable = false;
			addChild(_lblGame)
			
			_start();
		}
		
		private function _clickButton(index:int):void
		{
			var result:int = _game.play(index + 1);
			switch (result) {
				case GuesGame.ERROR:
					_lblGame.text = _game.counter + ': Error';
					break;
				case GuesGame.WIN:
					_lblGame.text = _game.counter + ': Win!';
					break;
				case GuesGame.LOSE:
					_lblGame.text = _game.counter + ': Lose :-(';
					break;
				case GuesGame.GREATER:
					_lblGame.text = _game.counter + ': Greater';
					break;
				case GuesGame.LESS:
					_lblGame.text = _game.counter + ': Less';
					break;
			}
		}
		
		private function _start():void
		{
			_game.start();
			_lblGame.text = 'Try to gues from 1 to 10 in 3 attempts?';
			
			/*
			var n:int = getTimer();
			for (var i:int = 0; i < 10000; ++i)
			{
				_game.test();
			}
			_lblGame.text = '' + (getTimer() - n);
			*/
		}
		
		private var _game:GuesGame;
		private var _lblGame:TextField;
	}
	
}