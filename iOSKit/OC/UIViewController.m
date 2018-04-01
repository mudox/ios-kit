//
// UIViewController.m
// ChangShou
//
// Created by Mudox on 06/02/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

#import "UIViewController.h"

#import "UIView.h"
#import "UIAlertController.h"

@implementation UIViewController (MDX)

#pragma mark Instantiate from storyboard

+ (instancetype)mdx_loadFromStoryboard: (NSString *)storyboardName identifier: (NSString *)identifier {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
  return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (instancetype)mdx_loadFromStoryboard: (NSString *)storyboardName {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
  return [storyboard instantiateInitialViewController];
}

#pragma mark - Present simple alert

- (void)mdx_alertWith: (NSString *)spell {
  [self presentViewController:[UIAlertController mdx_alertWith:spell] animated:YES completion:nil];
}

#pragma mark Present simple prompt

- (void)mdx_promptWith: (NSString *)spell completion: (void (^)(BOOL))block {
  [self presentViewController:[UIAlertController mdx_promptWith:spell completion:block] animated:YES completion:nil];
}

#pragma mark Present simple action sheet

- (void)mdx_showActionsWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actionTitles completion: (void (^)(NSString *selectedTitle))block {
  [self presentViewController:[UIAlertController mdx_actionSheetWithTitle:title message:message actionTitles:actionTitles completion:block] animated:YES completion:nil];
}

@end
