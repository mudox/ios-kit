//
//  UITextField.h
//  ChangShou
//
//  Created by Mudox on 15/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MDX)

/**
 *
 * Return YES If -hasText return NO or length equal 0 after trimming white spaces.
 *
 */
@property (assign, readonly, nonatomic) BOOL mdx_hasContentAfterTrimming;

/**
 *  Compare the 2 fields to see if they have same content after trimming.
 *
 *  @param otherField The other text field.
 *
 *  @return YES if, the contents after trimming are equal, otherwise NO. If either of them has nil content, return NO.
 */
- (BOOL)mdx_trimmedContentEqualTo:(UITextField *)otherField;

- (BOOL)mdx_matchesRegexString:(NSString *)regexString;

- (BOOL)mdx_matchesRegexString:(NSString *)regexString options:(NSRegularExpressionOptions)options;

@end

NS_ASSUME_NONNULL_END
