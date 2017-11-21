//
//  UITextView.h
//  ChangShou
//
//  Created by Mudox on 15/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (MDX)

/**
 *
 * Return YES If -hasText return NO or length equal 0 after trimming white spaces.
 *
 */
@property (assign, readonly, nonatomic) BOOL mdx_hasContent;

@end
