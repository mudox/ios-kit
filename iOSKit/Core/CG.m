//
//  CG.m
//  ChangShou
//
//  Created by Mudox on 17/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

#import "CG.h"

@implementation CG

+ (CGSize)size:(CGSize)size aspectFitToBoundingSize:(CGSize)boundingSize {
  CGFloat minRatio = fmin(boundingSize.width / size.width, boundingSize.height / size.height);
  return CGSizeMake(size.width * minRatio, size.height *minRatio);
}

+ (CGSize)size:(CGSize)size aspectFillToBoundingSize:(CGSize)boundingSize {
  CGFloat maxRatio = fmax(boundingSize.width / size.width, boundingSize.height / size.height);
  return CGSizeMake(size.width * maxRatio, size.height *maxRatio);
}

+ (CGFloat)degreesForRadians:(CGFloat)radions {
  return radions * 180 / M_PI;
}

+ (CGFloat)radiansForDegrees:(CGFloat)degrees {
  return degrees * M_PI / 180;
}

@end
