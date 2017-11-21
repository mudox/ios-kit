//
// UIApplication.m
// ChangShou
//
// Created by Mudox on 01/03/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import JacKit;

#import "The.h"

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#import "The.h"
#import "UIApplication.h"
#import "UIDevice.h"

@implementation UIApplication (MDX)

- (void)mdx_observeAppStates
{

  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  NSDictionary         *dict   = @{
    // active state
    UIApplicationDidBecomeActiveNotification: @"did become active",
    UIApplicationWillResignActiveNotification: @"will resign active",
    // background state
    UIApplicationDidEnterBackgroundNotification: @"did enter background",
    UIApplicationWillEnterForegroundNotification: @"will enter foreground",

    // launching state
    UIApplicationDidFinishLaunchingNotification: @"did finish launching",

    // memory warning
    UIApplicationDidReceiveMemoryWarningNotification: @"did receive memory warning",

    // terminat state
    UIApplicationWillTerminateNotification: @"will terminate",

    // significant time changing
    UIApplicationSignificantTimeChangeNotification: @"siginificant time change",

    // status bar
    UIApplicationWillChangeStatusBarOrientationNotification: @"will change status bar orientation",
    UIApplicationDidChangeStatusBarOrientationNotification: @"did change status bar orientation",
    UIApplicationWillChangeStatusBarFrameNotification: @"will change status bar frame",
    UIApplicationDidChangeStatusBarFrameNotification: @"did change status bar frame",

    UIApplicationBackgroundRefreshStatusDidChangeNotification: @"did change background refresh status",

    // protected data
    UIApplicationProtectedDataWillBecomeUnavailable: @"prototected data will become unavailable",
    UIApplicationProtectedDataDidBecomeAvailable: @"protected data did become available",
  };

  [dict enumerateKeysAndObjectsUsingBlock:^(id _Nonnull name, id _Nonnull text, BOOL * _Nonnull stop) {
     [center addObserverForName:name object:[UIApplication sharedApplication] queue:nil usingBlock:^(NSNotification *_Nonnull note) {
        DDLogWarn(@"Application State] %@", text);
      }];
   }];
}

- (void)mdx_greet
{
  NSString *appName          = [theBundle objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleNameKey];
  NSString *bundleIdentifier = theBundle.bundleIdentifier;
  NSString *version          = [theBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  NSString *build            = [theBundle objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];
  NSString *deviceName       = theDevice.name;
  NSString *deviceModel      = theDevice.localizedModel;
  NSString *isDebugMode      = BOOLSYMBOL(theApp.mdx_isInDebugMode);
  NSString *isSimulator      = BOOLSYMBOL(theDevice.mdx_isSimulator);
  NSString *systemName       = theDevice.systemName;
  NSString *systemVersion    = theDevice.systemVersion;

  NSString *lines = [
    @[
      [NSString stringWithFormat:@"App %@] launched", appName ],

      @">> [App]",
      [NSString stringWithFormat:@">>   bundle identifier: %@", bundleIdentifier],
      [NSString stringWithFormat:@">>     release version: %@", version],
      [NSString stringWithFormat:@">>       build version: %@", build],
      [NSString stringWithFormat:@">>       is debug mode: %@", isDebugMode],

      @">> [Device]",
      [NSString stringWithFormat:@">>         device name: %@", deviceName],
      [NSString stringWithFormat:@">>        device model: %@", deviceModel],
      [NSString stringWithFormat:@">>        is simulator: %@", isSimulator],

      @">> [System]",
      [NSString stringWithFormat:@">>         system name: %@", systemName],
      [NSString stringWithFormat:@">>      system version: %@", systemVersion],

      @"\n",
    ] componentsJoinedByString: @"\n"];

  DDLogInfo(@"%@", lines);
}

- (BOOL)mdx_isInDebugMode
{
#ifdef DEBUG
  return YES;
#else
  return NO;
#endif
}

@end
