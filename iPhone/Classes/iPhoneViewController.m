//
//  iPhoneViewController.m
//  iPhone
//
//  Created by Alex on 14.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iPhoneViewController.h"

@interface iPhoneViewController()
- (void)_start;
- (void)_play:(int)a;
@end


@implementation iPhoneViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
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
	[self _start];
}



/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	lua_close(_L);
}


- (void)dealloc {
    [super dealloc];
}



// UI event handlers

- (IBAction)start {
	[self _start];
}
- (IBAction)play:(id)sender {
	UIButton* btn = (UIButton *)sender;
	int a = [btn.currentTitle intValue];
	if (1 <= a && a <= 10)
		[self _play:a];
}


// UI implementation

- (void)_start {
	_lblMessage.text = @"Try to gues a number between 1 and 10 in 3 attempts.";
	
	lua_getglobal(_L, "gameStart");
	lua_pcall(_L, 0, 0, 0);
	
}
- (void)_play:(int)a {
	lua_getglobal(_L, "gamePlay");
	lua_pushnumber(_L, a);
	lua_pcall(_L, 1, 1, 0);
	int result = lua_tonumber(_L, 1);
	lua_pop(_L, 1);
	switch (result)
	{
		case 1: // WIN
			_lblMessage.text = @"Win! :-)";
			break;
		case 2: // LOSE
			_lblMessage.text = @"Lose :-(";
			break;
		case 3: // GREATER
			_lblMessage.text = @"Greater";
			break;
		case 4: // LESS
			_lblMessage.text = @"Less";
			break;
		default:
			_lblMessage.text = @"Error";
			break;
			
	}
}


@end
