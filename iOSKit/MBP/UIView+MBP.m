//
// UIView+MBP.m
// ChangShou
//
// Created by Mudox on 08/03/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import JacKit;

#import "objc/runtime.h"
#import "UIView+MBP.h"

static HUDStyle              _style = HUDStyleTextOnlyLight;
static HUDConfigurationBlock _customHUDConfigurationBlock;

/**
   predefined configuration block
 */
static HUDConfigurationBlock _textOnlyLightBlurConfigurationBlock;
static HUDConfigurationBlock _textOnlyDarkBlurConfigurationBlock;
static HUDConfigurationBlock _textOnlyLightConfigurationBlock;
static HUDConfigurationBlock _textOnlyDarkConfigurationBlock;

static NSDictionary *_blockForStyle;

void initBlocks()
{
  _textOnlyLightBlurConfigurationBlock = ^(MBProgressHUD *hud) {
    hud.mode            = MBProgressHUDModeText;
    hud.label.textColor = [UIColor blackColor];
  };
  _textOnlyDarkBlurConfigurationBlock = ^(MBProgressHUD *hud) {
    hud.mode            = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
  };
  _textOnlyLightConfigurationBlock = ^(MBProgressHUD *hud) {
    hud.mode                      = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    hud.label.textColor           = [UIColor blackColor];
  };
  _textOnlyDarkConfigurationBlock = ^(MBProgressHUD *hud) {
    hud.mode                      = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor           = [UIColor whiteColor];
  };

  _blockForStyle = @{
    @(HUDStyleTextOnlyLightBlur): _textOnlyLightBlurConfigurationBlock,
    @(HUDStyleTextOnlyDarkBlur): _textOnlyDarkBlurConfigurationBlock,
    @(HUDStyleTextOnlyLight): _textOnlyLightConfigurationBlock,
    @(HUDStyleTextOnlyDark): _textOnlyDarkConfigurationBlock,
  };
}

@implementation UIView (MBP)

+ (void)initialize
{
  if (self != [UIView class])
    return;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    initBlocks();
    self.hud_defaultStyle = HUDStyleTextOnlyLight;
    _customHUDConfigurationBlock = nil;
  });
}

+ (HUDStyle)hud_defaultStyle
{
  return _style;
}

+ (void)setHud_defaultStyle: (HUDStyle)style
{
  _style = style;
}

+ (void (^)(MBProgressHUD *))hud_defaultConfiguration
{
  return _customHUDConfigurationBlock;
}

+ (void)setHud_defaultConfiguration: (void (^)(MBProgressHUD *))block
{
  _customHUDConfigurationBlock = block;
}

- (MBProgressHUD *)hud_view
{
  if (objc_getAssociatedObject(self, @selector(hud_view)) == nil)
  {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];

    [self setHud_view:hud];
  }

  return objc_getAssociatedObject(self, @selector(hud_view));
}

- (void)setHud_view: (MBProgressHUD *)hud
{
  objc_setAssociatedObject(self, @selector(hud_view), hud, OBJC_ASSOCIATION_ASSIGN);
}

- (void)hud_setText: (NSString *)text
{
  self.hud_view.label.text = text;
}

- (void)hud_configure
{
  if (_customHUDConfigurationBlock != nil)
  {
    _customHUDConfigurationBlock(self.hud_view);
  }
  else
  {
    HUDConfigurationBlock block = (HUDConfigurationBlock)_blockForStyle[@(UIView.hud_defaultStyle)];
    block(self.hud_view);
  }
}

- (void)hud_showWithText: (NSString *)text
{
  [self hud_configure];
  self.hud_view.label.text = text;
  [self.hud_view showAnimated:YES];
}

- (void)hud_showText: (NSString *)text hideIn: (NSTimeInterval)delay
{
  [self hud_configure];
  self.hud_view.label.text = text;
  [self.hud_view showAnimated:YES];
  [self.hud_view hideAnimated:YES afterDelay:delay];
}

- (void)hud_blinkWithText: (NSString *)text for: (NSTimeInterval)delay
{
  [self hud_configure];
  self.hud_view.label.text = text;
  [self.hud_view showAnimated:YES];
  [self.hud_view hideAnimated:YES afterDelay:delay];
}

- (void)hud_blinkWithText: (NSString *)text
{
  [self hud_blinkWithText:text for:1];
}

- (void)hud_hide
{
  [self.hud_view hideAnimated:YES];
}

- (void)hud_hideIn: (NSTimeInterval)delay
{
  [self.hud_view hideAnimated:YES afterDelay:delay];
}

@end
