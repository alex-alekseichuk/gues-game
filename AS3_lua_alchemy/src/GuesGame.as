package  
{
	import flash.utils.getTimer;
	import luaAlchemy.LuaAlchemy;
	
	/**
	 * ...
	 * @author Alexander Alexeychuk
	 */
	public class GuesGame 
	{
		public static var ERROR:int = 0;
		public static var WIN:int = 1;
		public static var LOSE:int = 2;
		public static var GREATER:int = 3;
		public static var LESS:int = 4;
		
		public function GuesGame() 
		{
			_lua = new LuaAlchemy();
			var luaCode:String = '\
				GuesGame = {}\
				\
				GuesGame.WIN = 1\
				GuesGame.LOSE = 2\
				GuesGame.GREATER = 3\
				GuesGame.LESS = 4\
				\
				GuesGame.MIN = 1\
				GuesGame.MAX = 10\
				\
				GuesGame.MAX_TRY = 3\
				\
				function GuesGame:new()\
					return setmetatable({\
						_counter = GuesGame.MAX_TRY\
					}, {\
						__index = GuesGame\
					})\
				end\
				\
				function GuesGame:start()\
					self._x = math.random(GuesGame.MIN, GuesGame.MAX)\
					self._counter = 0\
				end\
				function GuesGame:getCounter()\
					return self._counter\
				end\
				function GuesGame:play(a)\
					if self._counter >= GuesGame.MAX_TRY then\
						return GuesGame.LOSE\
					end\
					self._counter = self._counter + 1\
					if a == self._x then\
						return GuesGame.WIN\
					else\
						if self._counter >= GuesGame.MAX_TRY then\
							return GuesGame.LOSE\
						elseif self._x > a then\
							return GuesGame.GREATER\
						else\
							return GuesGame.LESS\
						end\
					end\
				end\
				math.randomseed(os.time())\
				math.random()\
				math.random()\
				math.random()\
				game = GuesGame.new()\
				';
			_lua.doString(luaCode);
		}
		
		public function start():void
		{
			_lua.doString('game:start()');
		}
		
		public function play(gues:int):int
		{
			var aResult:Array = _lua.doString('return game:play(' + gues + ')');
			if (aResult[0])
			{
				return aResult[1];
			} else {
				trace('error: ' + aResult[1]);
				return 0;
			}
		}

		public function get counter():int
		{
			return _lua.doString('return game:getCounter()')[1];
		}

		public function test():void
		{
			_lua.doString('return 0');
		}
		
		private var _lua:LuaAlchemy;
		
	}

}