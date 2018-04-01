//
//  CG.h
//  ChangShou
//
//  Created by Mudox on 17/03/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;

@interface CG : NSObject

+ (CGSize)size:(CGSize)size aspectFitToBoundingSize:(CGSize)boundingSize NS_SWIFT_UNAVAILABLE("use coorespondding extension method instead");

+ (CGSize)size:(CGSize)size aspectFillToBoundingSize:(CGSize)boundingSize NS_SWIFT_UNAVAILABLE("use coorespondding extension method instead");

@end
