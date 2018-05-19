//
//  UIDevice.m
//  ChangShou
//
//  Created by Mudox on 16/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import AudioToolbox;

#import "UIDevice.h"

@implementation UIDevice (MDX)

- (void)mdx_vibrate {
  AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (BOOL)mdx_isSimulator {
#if TARGET_IPHONE_SIMULATOR
  return YES;
#else
  return NO;
#endif
}

@end
