//
// UIView.m
// ChangShou
//
// Created by Mudox on 04/02/2017.
// Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;

#import "UIView.h"

/**
   for Swift, the class name returned from NSStringFromClass including namespacing name (module name)

   @param class the class

   @return the class name without dot and its enclosing namespace name
 */
NSString *nameOfClass (Class class)
{
  NSString *name  = NSStringFromClass(class);
  NSRange   range = [name rangeOfString:@"." options:NSBackwardsSearch];
  if (range.location != NSNotFound)
  {
    name = [name substringFromIndex:range.location + 1];
  }

  return name;
}

@implementation UIView (MDX)

+ (instancetype)mdx_awakeFromNibNamed: (NSString *)name
{
  return [[UINib nibWithNibName:name bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

+ (instancetype)mdx_awakeFromNib
{
  return [self mdx_awakeFromNibNamed:nameOfClass(self)];
}

#pragma mark - Propety shortcuts

- (CGFloat)bWidth
{
  return CGRectGetWidth(self.bounds);
}

- (CGFloat)bHeight
{
  return CGRectGetHeight(self.bounds);
}

- (CGFloat)bMinX
{
  return CGRectGetMinX(self.bounds);
}

- (CGFloat)bMidX
{
  return CGRectGetMidX(self.bounds);
}

- (CGFloat)bMaxX
{
  return CGRectGetMaxX(self.bounds);
}

- (CGFloat)bMinY
{
  return CGRectGetMinY(self.bounds);
}

- (CGFloat)bMidY
{
  return CGRectGetMidY(self.bounds);
}

- (CGPoint)bCenter
{
  return CGPointMake(self.bMidX, self.bMidY);
}

- (CGFloat)bMaxY
{
  return CGRectGetMaxY(self.bounds);
}

- (CGFloat)fWidth
{
  return CGRectGetWidth(self.frame);
}

- (CGFloat)fHeight
{
  return CGRectGetHeight(self.frame);
}

- (CGFloat)fMinX
{
  return CGRectGetMinX(self.frame);
}

- (CGFloat)fMidX
{
  return CGRectGetMidX(self.frame);
}

- (CGFloat)fMaxX
{
  return CGRectGetMaxX(self.frame);
}

- (CGFloat)fMinY
{
  return CGRectGetMinY(self.frame);
}

- (CGFloat)fMidY
{
  return CGRectGetMidY(self.frame);
}

- (CGFloat)fMaxY
{
  return CGRectGetMaxY(self.frame);
}

#pragma mark - Move, scale & rotate view

-(instancetype)tMoveByX: (CGFloat)dx y: (CGFloat)dy
{
  CGRect frame = self.frame;
  self.frame = CGRectOffset(frame, dx, dy);
  return self;
}

-(instancetype)tScaleByX: (CGFloat)x y: (CGFloat)y
{
  CGAffineTransform t = self.transform;
  self.transform = CGAffineTransformScale(t, x, y);
  return self;
}

-(instancetype)tRotateByAngle: (CGFloat)angle;
{
  CGFloat degree = angle * M_PI / 180;
  return [self tRotateByRadian:degree];
}

-(instancetype)tRotateByRadian: (CGFloat)degree;
{
  CGAffineTransform t = self.transform;
  self.transform = CGAffineTransformRotate(t, degree);
  return self;
}

@end
