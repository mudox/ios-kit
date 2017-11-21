//
//  UITextView.m
//  ChangShou
//
//  Created by Mudox on 15/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;
#import "UITextView.h"

@implementation UITextView (MDX)

- (BOOL)mdx_hasContent {
  NSString *trimmed = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  return trimmed.length != 0;
}

@end
