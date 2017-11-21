//
//  UIApplication.h
//  ChangShou
//
//  Created by Mudox on 01/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (MDX)

/**
   Log a line when App state transition happens.
 */
- (void)mdx_observeAppStates;

/**
   Log out app session basic info, typically cal it in -application:didFinishLaunchingWithOptions: method
 */
- (void)mdx_greet;

@property (assign, readonly, nonatomic) BOOL mdx_isInDebugMode;

@end
