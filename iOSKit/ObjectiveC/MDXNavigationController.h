//
//  MDXNavigationController.h
//  ChangShou
//
//  Created by Mudox on 13/03/2017.
//  Copyright © 2017 Mudox. All rights

/**
 *  Rationale behind:
 *
 *  `UINavigationController.interactivePopGestureRecognizer` has a built-in
 *  delegate, and meanwhile use the delegate object as its target.
 *
 *  The built-in pop gesture recognizer only trigger 'begin' state when use pan
 *  to right from screen edge.
 *
 *  The delegate object, as the target of the gesture recognizer, is also in charge
 *  of starting & managing the interactive transition process.
 */

@import UIKit;

typedef NS_ENUM (NSInteger, MDXNavigationControllerInteractivePopStyle) {
  MDXNavigationControllerInteractivePopStyleEdge = 0,
  MDXNavigationControllerInteractivePopStyleAnywhere,
  MDXNavigationControllerInteractivePopStyleDefault,
  MDXNavigationControllerInteractivePopStyleNone,
};

@interface MDXNavigationController : UINavigationController

@property (assign, nonatomic)  MDXNavigationControllerInteractivePopStyle InteractivePopStyle;
@property (strong, readonly, nonatomic) UIPanGestureRecognizer            *panAnywhereToPopGesture;

@end
