//
// UIView+MBP.h
// ChangShou
//
// Created by Mudox on 08/03/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import MBProgressHUD;

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, HUDStyle) {
  HUDStyleTextOnlyLightBlur = 0,
  HUDStyleTextOnlyDarkBlur,
  HUDStyleTextOnlyLight,
  HUDStyleTextOnlyDark,

};

typedef void (^HUDConfigurationBlock)(MBProgressHUD *hud);

@interface UIView (MBP)

#pragma mark Appearance defaults

@property (class, assign, nonatomic) HUDStyle hud_defaultStyle;

/**
   hud_defaultConfiguration block, if given, takes precedence over hud_defaultStyle.
 */
@property (class, strong, nonatomic)  HUDConfigurationBlock hud_defaultConfiguration;

#pragma mark Instance properties & methods

@property (strong, nonatomic) MBProgressHUD *hud_view;

- (void)hud_setText: (NSString *)text;

- (void)hud_showWithText: (NSString *)text;

- (void)hud_showText: (NSString *)text hideIn: (NSTimeInterval)delay;

- (void)hud_blinkWithText: (NSString *)text for: (NSTimeInterval)delay;

/**
   Show for 1 seconds

   @param text The text to show
 */
- (void)hud_blinkWithText: (NSString *)text;

- (void)hud_hide;

- (void)hud_hideIn: (NSTimeInterval)delay;

@end
