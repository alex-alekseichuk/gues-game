import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptEngineManager;

public class GuesGame {
    public static void main(String[] args) {
        //System.out.println("Hello!");

        ScriptEngineManager sem = new ScriptEngineManager();
        ScriptEngine e = sem.getEngineByExtension(".lua");
        ScriptEngineFactory f = e.getFactory();

        String luaCode =
"GuesGame = {}\n" +
"\n" +
"GuesGame.WIN = 1\n" +
"GuesGame.LOSE = 2\n" +
"GuesGame.GREATER = 3\n" +
"GuesGame.LESS = 4\n" +
"\n" +
"GuesGame.MIN = 1\n" +
"GuesGame.MAX = 10\n" +
"\n" +
"GuesGame.MAX_TRY = 3\n" +
"\n" +
"function GuesGame:new()\n" +
"	return setmetatable({\n" +
"		_counter = GuesGame.MAX_TRY\n" +
"	}, {\n" +
"		__index = GuesGame\n" +
"	})\n" +
"end\n" +
"\n" +
"function GuesGame:start()\n" +
"	self._x = math.random(GuesGame.MIN, GuesGame.MAX)\n" +
"	self._counter = 0\n" +
"end\n" +
"function GuesGame:play(a)\n" +
"	if self._counter >= GuesGame.MAX_TRY then\n" +
"		return GuesGame.LOSE\n" +
"	end\n" +
"	self._counter = self._counter + 1\n" +
"	if a == self._x then\n" +
"		return GuesGame.WIN\n" +
"	else\n" +
"		if self._counter >= GuesGame.MAX_TRY then\n" +
"			return GuesGame.LOSE\n" +
"		elseif self._x > a then\n" +
"			return GuesGame.GREATER\n" +
"		else\n" +
"			return GuesGame.LESS\n" +
"		end\n" +
"	end\n" +
"end\n"
"\n" +
"---------------------------------------------------\n" +
"--	Initialization\n" +
"---------------------------------------------------\n" +
"\n" +
"-- init random generator by current time in seconds since 1970\n" +
"math.randomseed(os.time()) -- but it's unique per second\n" +
"-- several times touch this generator to avoid repeat on start\n" +
"math.random()\n" +
"math.random()\n" +
"math.random()\n" +
"\n" +
"game = GuesGame.new()\n" +
"\n" +
"\n" +
"-- external interface\n" +
"\n" +
"function gameStart()\n" +
"  game:start()\n" +
"end\n" +
"function gamePlay(a)\n" +
"  return game:play(a)\n" +
"end\n" +
"\n";

        e.eval(luaCode);
    }
}