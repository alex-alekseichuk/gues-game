#import <Foundation/Foundation.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

void _start(lua_State *L)
{
    lua_getglobal(L, "gameStart");
    lua_pcall(L, 0, 0, 0);
    printf("Try to gues number between 1 and 10 in 3 attempts\n");
}

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    //NSLog(@"Comming soon...");

	lua_State *L=lua_open();
	luaL_openlibs(L);

	luaL_dofile(L, "./GuesGame.lua");

	char line[11];

	printf("q - quit, s - start new game, 1-10 - gues play\n");

	_start(L);

	for (;;)
	{
		fgets(line, 10, stdin);
		line[strlen(line)-1] = '\0';
		if (strlen(line) > 0)
		{
			if (!strcmp("q", line))
			{
				break;
			}
			if (!strcmp("s", line))
			{
				_start(L);
			}
			int a = atoi(line);
			if (1 <= a && a <= 10)
			{
				lua_getglobal(L, "gamePlay");
				lua_pushnumber(L, a);
				lua_pcall(L, 1, 1, 0);

				int result = lua_tonumber(L, 1);

				lua_pop(L, 1);
				switch (result)
				{
					case 1: // WIN
						printf("Win! :-)\n");
						break;
					case 2: // LOSE
						printf("Lose :-(\n");
						break;
					case 3: // GREATER
						printf("Greater\n");
						break;
					case 4: // LESS
						printf("Less\n");
						break;
					default:
						printf("Error\n");
				}
			}
		}
	}

	lua_close(L);

    [pool drain];
    return 0;
}
