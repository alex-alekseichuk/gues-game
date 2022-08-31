//
//  iPhoneViewController.h
//  iPhone
//
//  Created by Alex on 14.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "lua/lua.h"
#include "lua/lualib.h"
#include "lua/lauxlib.h"

@interface iPhoneViewController : UIViewController {
@private
	lua_State *_L;
@protected
	IBOutlet UILabel *_lblMessage;
}
-(IBAction)start;
-(IBAction)play:(id)sender;

@end

