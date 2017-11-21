//
//  NSString.m
//  Pods
//
//  Created by Mudox on 01/04/2017.
//
//

#import "NSString.h"

@import JacKit;

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@implementation NSString (MDX)

- (NSString *)mdx_trimmed {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)mdx_isEmptyAfterTrimming {
  return self.mdx_trimmed.length == 0;
}

- (BOOL)mdx_trimmedContentEqualTo:(NSString *)otherString {
  return [self.mdx_trimmed isEqualToString:otherString.mdx_trimmed];
}

- (BOOL)mdx_matchRegex:(NSString *)regexString {
  return [self mdx_matchRegex:regexString options:kNilOptions];
}

- (BOOL)mdx_matchRegex:(NSString *)regexString options:(NSRegularExpressionOptions)options {
  // create regex with options if any
  NSError             *error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:options error:&error];
  if (error != nil) {
    DDLogError(@"%@ %@] failed to create NSRegularExpression instance:\n>> %@", THIS_FILE, THIS_METHOD, error.localizedDescription);
    return NO;
  }

  // match regex
  return [regex numberOfMatchesInString:self.mdx_trimmed options:kNilOptions range:NSMakeRange(0, self.mdx_trimmed.length)] == 1;
}

@end
