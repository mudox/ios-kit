//  The.h
//  ChangShou
//
//  Created by Mudox on 11/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

#define theDevice                   ((The.device))
#define theApp                      ((The.app))
#define theAppDelegate              (((AppDelegate *)The.appDelegate))
#define theScreen                   ((The.screen))
#define theWindow                   ((The.window))
#define theBundle                   ((The.bundle))
#define theFileManager              ((The.fileManager))
#define theUserDefaults             ((The.userDefaults))
#define theNotificationCenter       ((The.notificationCenter))

#define theRootViewController       ((The.rootViewController))
#define theRootNavigationController ((The.rootNavigationController))
#define theRootTabBarController     ((The.rootTabBarController))

@interface The : NSObject

#pragma mark Commonly accessed global objects

@property (class, readonly, nonatomic) UIDevice                              *device;
@property (class, readonly, nonatomic) UIApplication                         *app;
@property (class, readonly, nonatomic) id<UIApplicationDelegate> appDelegate NS_SWIFT_UNAVAILABLE("you should extension The manually in AppDelegate.swift");
@property (class, readonly, nonatomic) UIScreen                              *screen;
@property (class, readonly, nonatomic) UIWindow                              *window;
@property (class, readonly, nonatomic) NSBundle                              *bundle;
@property (class, readonly, nonatomic) NSFileManager                         *fileManager;
@property (class, readonly, nonatomic) NSUserDefaults                        *userDefaults;
@property (class, readonly, nonatomic) NSNotificationCenter                  *notificationCenter;

#pragma mark Root level view controller
/**
 *  find and return the root view controller associated with the key window of the app instance.
 *
 *  @return root view controller if any
 */
@property (class, readonly, nonatomic, nullable) UIViewController *rootViewController;
/**
 *  find and see if the root view controller is a navigation controller
 *
 *  @return nil if the root view controller is not a navigation controller
 */
@property (class, readonly, nonatomic, nullable) UINavigationController *rootNavigationController;
/**
 *  find and see if the root view controller is a tab bar controller
 *
 *  @return nil if the root view controller is not a tab bar controller
 */
@property (class, readonly, nonatomic, nullable) UITabBarController *rootTabBarController;

#pragma mark Commonly accessed values


@property (class, assign, readonly, nonatomic) CGFloat screenWidth;
@property (class, assign, readonly, nonatomic) CGFloat screenHeight;

@property (class, readonly, strong, nonatomic) NSString *appVersion;

@end

NS_ASSUME_NONNULL_END
