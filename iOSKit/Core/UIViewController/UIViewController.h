//
// UIViewController.h
// ChangShou
//
// Created by Mudox on 06/02/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;

#import "UIAlertController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MDX)

#pragma mark Instantiate from storyboard

/**
 *  Instantiate from a storyboard in main bundle with given reference ID

 *  @param storyboardName File name of the storyboard without the 'storyboard' extension
 *  @param identifier     Reference ID of the view controller scene
 *
 *  @return The instantiated view controller
 */
+ (instancetype)mdx_loadFromStoryboard: (NSString *)storyboardName identifier: (NSString *)identifier NS_SWIFT_NAME(init(storyboard:identifier:));

/**
 *  Instantiate as initial view controller from the storyboard.
 *
 *  @param storyboardName File name of the storyboard without the 'storyboard' extension.
 *
 *  @return The instantiated view controller
 */
+ (instancetype)mdx_loadFromStoryboard: (NSString *)storyboardName NS_SWIFT_NAME(init(storyboard:));

#pragma mark - Incant an alert / prompt

/**
   Present an alert style `UIAlertController` from the given string pattern with
   only one OK button.

   @code
   // all components specified
   [UIAlertController mdx_alertWith: @"title:message->buttonTitle"];
   // only title
   [UIAlertController mdx_alertWith: @"title"];
   // only message
   [UIAlertController mdx_alertWith: @":onlyMessage"];
   // title and button title
   [UIAlertController mdx_alertWith: @"title->buttonTitle"];
   // message and button title
   [UIAlertController mdx_alertWith: @":message->buttonTitle"];
   @endcode

   @param spell Craft the spell like "[title][:message][->bbuttonTitle]"

   @warning At least either of title or message should be appear in the string.
 */
- (void)mdx_alertWith: (NSString *)spell;

/**
   Present an alert style `UIAlertController` from the given string pattern with
   2 buttons, the left one is cancel button, and the right one is proceed button.

   @code
   // all components specified
   [UIAlertController mdx_alertWith: @"title:message->NO|YES"];
   // only title
   [UIAlertController mdx_alertWith: @"title"];
   // only message
   [UIAlertController mdx_alertWith: @":onlyMessage"];
   // title and button title
   [UIAlertController mdx_alertWith: @"title->NO|YES"];
   // message and button title
   [UIAlertController mdx_alertWith: @":message->NO|YES"];
   @endcode

   @param spell Craft the spell like "[title][:message][->cancelTitle|proceedTitile]"

   @warning At least either of title or message should be appear in the string.
 */
- (void)mdx_promptWith: (NSString *)spell completion: (void (^)(BOOL))block;

#pragma mark Present simple action sheet

- (void)mdx_showActionsWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actionTitles completion: (void (^)(NSString *selectedTitle))block;

@end

NS_ASSUME_NONNULL_END
