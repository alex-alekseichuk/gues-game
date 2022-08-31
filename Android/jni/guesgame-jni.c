#include <string.h>
#include <jni.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

static lua_State *_L;

void
Java_com_kikudjiro_guesgame_AndroidGuesGameActivity_init( JNIEnv* env,
                                                  jobject thiz )
{
	_L = lua_open();
	luaL_openlibs(_L);
	
	luaL_dostring(_L, "\
				\
				--[[\
				Cool example: The game to gues a number between 1 and 10 in 3 attempts.\
				]]--\
				\
				\
				---------------------------------------------------\
				--	Gues game model\
				---------------------------------------------------\
				\n\
				GuesGame = {}\n\
				\
				GuesGame.WIN = 1\n\
				GuesGame.LOSE = 2\n\
				GuesGame.GREATER = 3\n\
				GuesGame.LESS = 4\n\
				\
				GuesGame.MIN = 1\n\
				GuesGame.MAX = 10\n\
				\
				GuesGame.MAX_TRY = 3\n\
				\
				function GuesGame:new()\n\
				  return setmetatable({\n\
					_counter = GuesGame.MAX_TRY\n\
				  }, {\n\
					__index = GuesGame\n\
				  })\n\
				end\n\
				\
				function GuesGame:start()\n\
				  self._x = math.random(GuesGame.MIN, GuesGame.MAX)\n\
				  self._counter = 0\n\
				end\n\
				function GuesGame:play(a)\n\
				  if self._counter >= GuesGame.MAX_TRY then\n\
					return GuesGame.LOSE\n\
				  end\n\
				  self._counter = self._counter + 1\n\
				  if a == self._x then\n\
					return GuesGame.WIN\n\
				  else\n\
					if self._counter >= GuesGame.MAX_TRY then\n\
						return GuesGame.LOSE\n\
					elseif self._x > a then\n\
						return GuesGame.GREATER\n\
					else\n\
						return GuesGame.LESS\n\
					end\n\
				  end\n\
				end\n\
				\
				\
				---------------------------------------------------\
				--	Initialization\
				---------------------------------------------------\
				\
				-- init random generator by current time in seconds since 1970\
				math.randomseed(os.time()) -- but it's unique per second\n\
				-- several times touch this generator to avoid repeat on start\
				math.random()\n\
				math.random()\n\
				math.random()\n\
				\
				game = GuesGame.new()\n\
				\n\
				\n\
				-- external interface\n\
				\n\
				function gameStart()\n\
				  game:start()\n\
				end\n\
				function gamePlay(a)\n\
				  return game:play(a)\n\
				end\n\
				\n\
				");
}

void
Java_com_kikudjiro_guesgame_AndroidGuesGameActivity_start( JNIEnv* env,
                                                  jobject thiz )
{
	lua_getglobal(_L, "gameStart");
	lua_pcall(_L, 0, 0, 0);
}

int
Java_com_kikudjiro_guesgame_AndroidGuesGameActivity_play( JNIEnv* env,
                                                  jobject thiz, int a)
{
	int result;
	lua_getglobal(_L, "gamePlay");
	lua_pushnumber(_L, a);
	lua_pcall(_L, 1, 1, 0);
	result = lua_tonumber(_L, 1);
	lua_pop(_L, 1);
	return result;
}

