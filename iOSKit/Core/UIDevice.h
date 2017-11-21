//
//  UIDevice.h
//  ChangShou
//
//  Created by Mudox on 16/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (MDX)

- (void)mdx_vibrate;

@property (assign, readonly, nonatomic) BOOL mdx_isSimulator;

@end
