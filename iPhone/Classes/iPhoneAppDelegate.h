//
//  iPhoneAppDelegate.h
//  iPhone
//
//  Created by Alex on 14.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneViewController;

@interface iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iPhoneViewController *viewController;

@end

