//
//  MDXNavigationController.m
//  ChangShou
//
//  Created by Mudox on 13/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import "MDXNavigationController.h"

@import JacKit;

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface MDXNavigationController () <UIGestureRecognizerDelegate>

@property (strong, readonly, nonatomic) id<UIGestureRecognizerDelegate> popTransitionController;

@end

@implementation MDXNavigationController

- (void)awakeFromNib {
  [super awakeFromNib];
  _InteractivePopStyle = MDXNavigationControllerInteractivePopStyleDefault;
}

@synthesize popTransitionController = _popTransitionController;
- (id<UIGestureRecognizerDelegate>)popTransitionController {
  if (_popTransitionController == nil) {
    assert(self.interactivePopGestureRecognizer.delegate != nil);
    _popTransitionController = self.interactivePopGestureRecognizer.delegate;
  }

  return _popTransitionController;
}

@synthesize panAnywhereToPopGesture = _panAnywhereToPopGesture;


- (UIPanGestureRecognizer *)panAnywhereToPopGesture {
  if (_panAnywhereToPopGesture == nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    _panAnywhereToPopGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popTransitionController action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    _panAnywhereToPopGesture.delegate = self;
  }

  return _panAnywhereToPopGesture;
}

- (void)setInteractivePopStyle:(MDXNavigationControllerInteractivePopStyle)style {
  if (_InteractivePopStyle == style) {
    DDLogWarn(@"%@ %@] reset with %ld", THIS_FILE, THIS_METHOD, (long)style);
  }

  // reset status
  self.interactivePopGestureRecognizer.enabled  = YES;
  self.interactivePopGestureRecognizer.delegate = self.popTransitionController;
  [self.view removeGestureRecognizer:self.panAnywhereToPopGesture];

  switch (style) {

  case MDXNavigationControllerInteractivePopStyleDefault: {

  } break;

  // enable the default pan from edge to pop behavior even if the back button is not the built-in one.
  case MDXNavigationControllerInteractivePopStyleEdge: {
    self.interactivePopGestureRecognizer.delegate = self;
  } break;

  case MDXNavigationControllerInteractivePopStyleAnywhere: {
    self.interactivePopGestureRecognizer.enabled = NO;
    [self.view addGestureRecognizer:self.panAnywhereToPopGesture];
  } break;

  case MDXNavigationControllerInteractivePopStyleNone: {
    self.interactivePopGestureRecognizer.enabled = NO;
  } break;

  }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  BOOL moreThanOneViewControllers = self.viewControllers.count > 1;

  if (gestureRecognizer == self.panAnywhereToPopGesture) {
    BOOL panToRight = [self.panAnywhereToPopGesture translationInView:self.view].x > 0;
    return moreThanOneViewControllers && panToRight;

  } else {
    return moreThanOneViewControllers;
  }
}

@end
