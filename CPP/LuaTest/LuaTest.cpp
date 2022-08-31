// LuaTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include "lua.hpp"

static int printy(lua_State *L)
{
	int n=lua_gettop(L);
	int i;
	for (i=1; i<=n; i++)
	{
		if (i>1)
			printf("\t");
		if (lua_isstring(L,i))
			printf("%s",lua_tostring(L,i));
		else if (lua_isnil(L,i))
			printf("%s","nil");
		else if (lua_isboolean(L,i))
			printf("%s",lua_toboolean(L,i) ? "true" : "false");
		else
			printf("%s:%p",luaL_typename(L,i),lua_topointer(L,i));
	}
	printf("\n");
	return 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	lua_State *L=lua_open();
	lua_register(L,"printy",printy);
	if (luaL_dofile(L,NULL)!=0)
		fprintf(stderr,"%s\n",lua_tostring(L,-1));
	lua_close(L);
	return 0;
}
