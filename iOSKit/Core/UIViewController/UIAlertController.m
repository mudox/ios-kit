//
//  UIAlertController.m
//  ChangShou
//
//  Created by Mudox on 06/02/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import JacKit;

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#import "UIAlertController.h"

@implementation UIAlertController (MDX)

#pragma mark Simple Alert

+ (instancetype)mdx_alertWith:(NSString *)spell {
  // regex
  NSString *titleRegex       = @"([^:]+?)";
  NSString *messageRegex     = @"(?::(.+?))";
  NSString *buttonTitleRegex = @"(?:->(.*))";
  NSString *regexString      = [NSString stringWithFormat:@"^%@?%@?%@?$", titleRegex, messageRegex, buttonTitleRegex];

  NSError             *error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:kNilOptions error:&error];
  if (error != nil) {
    DDLogError(@"%@ %@] failed to create NSRegularExpression instance:\n>> %@", THIS_FILE, THIS_METHOD, error.localizedDescription);
    return nil;
  }

  // parse
  NSTextCheckingResult *match = [regex firstMatchInString:spell options:kNilOptions range:NSMakeRange(0, spell.length)];
  if (match == nil) {
    DDLogError(@"%@ %@] failed to parse spell String %@:\n>> %@", THIS_FILE, THIS_METHOD, spell.debugDescription, error.localizedDescription);
    return nil;
  }

  // title if any
  NSRange  titleRange = [match rangeAtIndex:1];
  NSString *title;
  if (titleRange.location == NSNotFound) {
    title = nil;
  } else {
    title = [[spell substringWithRange:titleRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // message if any
  NSRange  messageRange = [match rangeAtIndex:2];
  NSString *message;
  if (messageRange.location == NSNotFound) {
    message = nil;
  } else {
    message = [[spell substringWithRange:messageRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // buttonTitle if any
  NSRange  buttonTitleRange = [match rangeAtIndex:3];
  NSString *buttonTitle;
  if (buttonTitleRange.location == NSNotFound) {
    buttonTitle = nil;
  } else {
    buttonTitle = [[spell substringWithRange:buttonTitleRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // either of title  or message should appear
  if (title == nil && messageRegex == nil) {
    DDLogError(@"%@ %@] title & message are absent in spell %@", THIS_FILE, THIS_METHOD, spell.debugDescription);
    return nil;
  }

  return [UIAlertController mdx_alertWithTitle:title message:message buttonTitle:buttonTitle];
}

+ (instancetype)mdx_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message buttonTitle:(NSString *_Nullable)buttonTitle {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:buttonTitle ? : @"确定" style:UIAlertActionStyleDefault handler:nil]];
  return alert;
}

#pragma mark Simple prompt

+ (instancetype)mdx_promptWith:(NSString *)spell completion:(void (^)(BOOL))block {
  // regex
  NSString *titleRegex       = @"([^:]+?)";
  NSString *messageRegex     = @"(?::(.+?))";
  NSString *buttonTitleRegex = @"(?:->([^|]+)\\|([^|].+))";
  NSString *regexString      = [NSString stringWithFormat:@"^%@?%@?%@?$", titleRegex, messageRegex, buttonTitleRegex];

  NSError             *error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:kNilOptions error:&error];
  if (error != nil) {
    DDLogError(@"%@ %@] failed to create NSRegularExpression instance:\n>> %@", THIS_FILE, THIS_METHOD, error.localizedDescription);
    return nil;
  }

  // parse
  NSTextCheckingResult *match = [regex firstMatchInString:spell options:kNilOptions range:NSMakeRange(0, spell.length)];
  if (match == nil) {
    DDLogError(@"%@ %@] failed to parse spell String %@:\n>> %@", THIS_FILE, THIS_METHOD, spell.debugDescription, error.localizedDescription);
    return nil;
  }

  // title if any
  NSRange  titleRange = [match rangeAtIndex:1];
  NSString *title;
  if (titleRange.location == NSNotFound) {
    title = nil;
  } else {
    title = [[spell substringWithRange:titleRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // message if any
  NSRange  messageRange = [match rangeAtIndex:2];
  NSString *message;
  if (messageRange.location == NSNotFound) {
    message = nil;
  } else {
    message = [[spell substringWithRange:messageRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // cancel button title if any
  NSRange  cancelTitleRange = [match rangeAtIndex:3];
  NSString *cancelTitle;
  if (cancelTitleRange.location == NSNotFound) {
    cancelTitle = nil;
  } else {
    cancelTitle = [[spell substringWithRange:cancelTitleRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // ok button title if any
  NSRange  okTitleRange = [match rangeAtIndex:4];
  NSString *okTitle;
  if (okTitleRange.location == NSNotFound) {
    okTitle = nil;
  } else {
    okTitle = [[spell substringWithRange:okTitleRange] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  }

  // either of title  or message should appear
  if (title == nil && messageRegex == nil) {
    DDLogError(@"%@ %@] title & message are absent in spell %@", THIS_FILE, THIS_METHOD, spell.debugDescription);
    return nil;
  }

  return [UIAlertController mdx_promptWithTitle:title message:message cancelButtonTitle:cancelTitle okButtonTitle:okTitle completion:block];
}

+ (instancetype)mdx_promptWithTitle:(NSString *_Nullable)title
                            message:(NSString *_Nullable)message
                  cancelButtonTitle:(NSString *)cancelTitle
                      okButtonTitle:(NSString *)okTitle
                         completion:(void (^)(BOOL))block {
  if (block == nil) {
    NSAssert(NO, @"need a block");
    return nil;
  }

  if (title == nil && message == nil) {
    NSAssert(NO, @"either title or message should not be nil");
    return nil;
  }

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:cancelTitle ? : @"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    block(NO);
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:okTitle ? : @"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
    block(YES);
  }]];
  return alert;
}

#pragma mark Simple action sheet

+ (instancetype)mdx_actionSheetWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles completion:(void (^)(NSString *))block {
  UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

  for (NSString *text in actionTitles) {
    UIAlertAction *action = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
      block(action.title);
    }];
    [sheet addAction:action];
  }

  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
  [sheet addAction:cancel];

  return sheet;
}

@end
