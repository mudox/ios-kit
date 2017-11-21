//
//  CALayer.h
//  ChangShou
//
//  Created by Mudox on 24/02/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (MDX)

/**
 *  Set `nil` to disable animation persistence.
 */
@property (strong, nonatomic) NSArray *mdx_persistentAnimationKeys;

/**
 *  Make current active animations persist through App transition to background / suspended state, restoring after becoming active again.
 */
- (void)mdx_persitAllAnimations;

@end
