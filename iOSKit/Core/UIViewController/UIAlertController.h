//
//  UIAlertController.h
//  ChangShou
//
//  Created by Mudox on 06/02/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (MDX)

#pragma mark Simple alert

/**
   Create an alert style `UIAlertController` from the given string pattern with
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

   @return The new alert style `UIAlertController`
 */
+ (instancetype)mdx_alertWith:(NSString *)spell;

+ (instancetype)mdx_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message buttonTitle:(NSString *_Nullable)buttonTitle;

#pragma mark Simple prompt

/**
   Create an alert style `UIAlertController` from the given string pattern with
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

   @return The new alert style `UIAlertController`
 */
+ (instancetype)mdx_promptWith:(NSString *)spell completion:(void (^)(BOOL))block;

+ (instancetype)mdx_promptWithTitle:(NSString *_Nullable)title
                            message:(NSString *_Nullable)message
                  cancelButtonTitle:(NSString *_Nullable)cancelTitle
                      okButtonTitle:(NSString *_Nullable)okTitle
                         completion:(void (^)(BOOL))block;

#pragma mark Simple action sheet

+ (instancetype)mdx_actionSheetWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles completion:(void (^)(NSString *))block;

@end

NS_ASSUME_NONNULL_END
