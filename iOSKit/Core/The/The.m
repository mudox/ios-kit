//
//  The.m
//  ChangShou
//
//  Created by Mudox on 11/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import "The.h"

@implementation The

#pragma mark Commonly accessed global objects

+ (UIDevice *)device {
  return UIDevice.currentDevice;
}

+ (UIApplication *)app {
  return UIApplication.sharedApplication;
}

+ (id<UIApplicationDelegate>)appDelegate {
  return self.app.delegate;
}

+ (UIScreen *)screen {
  return UIScreen.mainScreen;
}

+ (UIWindow *)window {
  return self.app.keyWindow;
}

+ (NSBundle *)bundle {
  return NSBundle.mainBundle;
}

+ (NSFileManager *)fileManager {
  return NSFileManager.defaultManager;
}

+ (NSUserDefaults *)userDefaults {
  return NSUserDefaults.standardUserDefaults;
}

+ (NSNotificationCenter *)notificationCenter {
  return NSNotificationCenter.defaultCenter;
}

#pragma mark Root level view controllers

+ (UIViewController *)rootViewController {
  return self.window.rootViewController;
}

+ (UINavigationController *)rootNavigationController {
  if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
    return (UINavigationController *)self.rootViewController;
  } else {
    return nil;
  }
}

+ (UITabBarController *)rootTabBarController {
  if ([self.rootViewController isKindOfClass:[UITabBarController class]]) {
    return (UITabBarController *)self.rootViewController;
  } else {
    return nil;
  }
}

#pragma mark Commonly accessed values

+ (CGFloat)screenWidth {
  return CGRectGetWidth(theScreen.bounds);
}

+ (CGFloat)screenHeight {
  return CGRectGetHeight(theScreen.bounds);
}

+ (NSString *)appVersion {
  return [theBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

@end
