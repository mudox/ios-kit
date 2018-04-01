//
//  UITextField.m
//  ChangShou
//
//  Created by Mudox on 15/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import JacKit;

#import "NSString.h"

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@import UIKit;
#import "UITextField.h"

@implementation UITextField (MDX)

- (BOOL)mdx_hasContentAfterTrimming {
  return !self.text.mdx_isEmptyAfterTrimming;
}

- (BOOL)mdx_trimmedContentEqualTo:(UITextField *)otherField {
  if (!self.hasText || !otherField.hasText) return NO;

  NSString *selfTrimmed  = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSString *otherTrimmed = [otherField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  return [selfTrimmed isEqualToString:otherTrimmed];
}

- (BOOL)mdx_matchesRegexString:(NSString *)regexString options:(NSRegularExpressionOptions)options {
  if (!self.hasText) return NO;

  // trim white spaces if any
  NSString *trimmed = self.text;
  trimmed = [trimmed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

  // create regex
  NSError             *error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:options error:&error];
  if (error != nil) {
    DDLogError(@"%@ %@] failed to create NSRegularExpression instance:\n>> %@", THIS_FILE, THIS_METHOD, error.localizedDescription);
    return NO;
  }

  // match regex
  return [regex numberOfMatchesInString:trimmed options:kNilOptions range:NSMakeRange(0, trimmed.length)] == 1;
}

- (BOOL)mdx_matchesRegexString:(NSString *)regexString {
  return [self mdx_matchesRegexString:regexString options:kNilOptions];
}
@end
