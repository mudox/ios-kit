//
// UIView.h
// ChangShou
//
// Created by Mudox on 04/02/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MDX)

/**
 *  Load view as the first (typically the only one) top level object from nib file in the main bundle.
 *
 *  @param name file name of the nib file in the main bundle without the 'nib' extension.
 *
 *  @return the view object.
 */
+ (instancetype)mdx_awakeFromNibNamed: (NSString *)name NS_SWIFT_NAME(mdx_awake(fromNibNamed:));

/**
   try to use its class name as the nib name to load from

   @return the view object
 */
+ (instancetype)mdx_awakeFromNib;

#pragma mark Property shortcuts

@property (assign, readonly, nonatomic) CGFloat bWidth;
@property (assign, readonly, nonatomic) CGFloat bHeight;

@property (assign, readonly, nonatomic) CGFloat bMinX;
@property (assign, readonly, nonatomic) CGFloat bMidX;
@property (assign, readonly, nonatomic) CGFloat bMaxX;
@property (assign, readonly, nonatomic) CGFloat bMinY;
@property (assign, readonly, nonatomic) CGFloat bMidY;
@property (assign, readonly, nonatomic) CGFloat bMaxY;

@property (assign, readonly, nonatomic) CGPoint bCenter;

@property (assign, readonly, nonatomic) CGFloat fWidth;
@property (assign, readonly, nonatomic) CGFloat fHeight;

@property (assign, readonly, nonatomic) CGFloat fMinX;
@property (assign, readonly, nonatomic) CGFloat fMidX;
@property (assign, readonly, nonatomic) CGFloat fMaxX;
@property (assign, readonly, nonatomic) CGFloat fMinY;
@property (assign, readonly, nonatomic) CGFloat fMidY;
@property (assign, readonly, nonatomic) CGFloat fMaxY;

#pragma mark - Move, scale & rotate view

/**
 * prefix `t` here means ahieve by modify `transform` property, not by `frame`
 */

-(instancetype)tMoveByX: (CGFloat)dx y: (CGFloat)dy;
-(instancetype)tScaleByX: (CGFloat)x y: (CGFloat)y;
-(instancetype)tRotateByAngle: (CGFloat)angle;
-(instancetype)tRotateByRadian: (CGFloat)degree;

@end

NS_ASSUME_NONNULL_END
