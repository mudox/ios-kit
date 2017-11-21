//
//  NSString.h
//  Pods
//
//  Created by Mudox on 01/04/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MDX)

@property (strong, readonly, nonatomic) NSString *mdx_trimmed;

@property (assign, readonly, nonatomic) BOOL mdx_isEmptyAfterTrimming;

- (BOOL)mdx_trimmedContentEqualTo:(NSString *)otherString;

- (BOOL)mdx_matchRegex:(NSString *)regexString;

- (BOOL)mdx_matchRegex:(NSString *)regexString options:(NSRegularExpressionOptions)options;

@end

NS_ASSUME_NONNULL_END
