//
// UIApplication.m
// ChangShou
//
// Created by Mudox on 01/03/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import JacKit;


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

    // background refresh
    UIApplicationBackgroundRefreshStatusDidChangeNotification: @"did change background refresh status",

    // protected data
    UIApplicationProtectedDataWillBecomeUnavailable: @"prototected data will become unavailable",
    UIApplicationProtectedDataDidBecomeAvailable: @"protected data did become available",
  };

  [dict enumerateKeysAndObjectsUsingBlock:^(id _Nonnull name, id _Nonnull text, BOOL * _Nonnull stop) {
     [center addObserverForName:name object:[UIApplication sharedApplication] queue:nil usingBlock:^(NSNotification *_Nonnull note) {
        JackDebugWithPrefix(@"App state changed", @"%@", text);
      }];
   }];
}

- (void)mdx_greet
{
  NSString *appName    = NSProcessInfo.processInfo.processName;
  NSString *appID      = theBundle.bundleIdentifier;
  NSString *appVersion = [theBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  NSString *appBuild   = [theBundle objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];

  NSString *deviceName  = theDevice.name;
  NSString *deviceModel = theDevice.localizedModel;
  NSString *deviceUUID = [theDevice.identifierForVendor UUIDString];

  NSString *isDebugMode = BOOLSYMBOL(theApp.mdx_isInDebugMode);
  NSString *isSimulator = BOOLSYMBOL(theDevice.mdx_isSimulator);

  NSString *systemName    = theDevice.systemName;
  NSString *systemVersion = theDevice.systemVersion;

  NSString *lines = [
    @[
      @"[App]",
      [NSString stringWithFormat:@"  - ID         :     %@", appID],
      [NSString stringWithFormat:@"  - Release    :     %@", appVersion],
      [NSString stringWithFormat:@"  - Build      :     %@", appBuild],
      [NSString stringWithFormat:@"  - Debug      :     %@", isDebugMode],

      @"[Device]",
      [NSString stringWithFormat:@"  - Name       :     %@", deviceName],
      [NSString stringWithFormat:@"  - Model      :     %@", deviceModel],
      [NSString stringWithFormat:@"  - UUID       :     %@", deviceUUID],
      [NSString stringWithFormat:@"  - Simulator  :     %@", isSimulator],

      @"[System]",
      [NSString stringWithFormat:@"  - Name       :     %@", systemName],
      [NSString stringWithFormat:@"  - Version    :     %@", systemVersion],

      @"\n",
    ] componentsJoinedByString: @"\n"];

  NSString *prefix = [NSString stringWithFormat:@"App %@ launched", appName];
  JackInfoWithPrefix(prefix, @"%@", lines);
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
