//
//  CALayer.m
//  ChangShou
//
//  Created by Mudox on 24/02/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

@import UIKit;

#import <objc/runtime.h>
#import "CALayer.h"

@interface AnimationContainer : NSObject

@property (weak, readonly, nonatomic) CALayer *layer;
@property (strong, nonatomic) NSArray         *keysToPersist;
@property (strong, nonatomic) NSDictionary    *persistedKeysAndAnimations;

- (instancetype)initWithLayer:(CALayer *)layer;

@end

@interface CALayer (MDXPrivate)

@property (strong, nonatomic) AnimationContainer *mdx_persistentAnimationContainer;

@end

@implementation CALayer (MDX)

#pragma mark Public

- (void)mdx_persitAllAnimations {
  self.mdx_persistentAnimationKeys = self.animationKeys;
}

- (NSArray *)mdx_persistentAnimationKeys {
  return self.mdx_persistentAnimationContainer.keysToPersist;
}

- (void)setMdx_persistentAnimationKeys:(NSArray *)keys {
  if (self.mdx_persistentAnimationContainer == nil) {
    self.mdx_persistentAnimationContainer = [[AnimationContainer alloc] initWithLayer:self];;
  }

  self.mdx_persistentAnimationContainer.keysToPersist = keys;
}

#pragma mark Associated object

- (void)setMdx_persistentAnimationContainer:(AnimationContainer *)container {
  objc_setAssociatedObject(self, @selector(mdx_persistentAnimationContainer), container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AnimationContainer *)mdx_persistentAnimationContainer {
  return objc_getAssociatedObject(self, @selector(mdx_persistentAnimationContainer));
}

#pragma mark Animation pause & resuem

- (void)mdx_pauseLayer {
  CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
  self.speed      = 0.0;
  self.timeOffset = pausedTime;
}

- (void)mdx_resumeLayer {
  CFTimeInterval pausedTime = [self timeOffset];
  self.speed      = 1.0;
  self.timeOffset = 0.0;
  self.beginTime  = 0.0;
  CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
  self.beginTime = timeSincePause;
}

@end

@implementation AnimationContainer

#pragma mark Lifecycle

- (void)dealloc {
  [self endObservingAppStates];
}

- (instancetype)initWithLayer:(CALayer *_Nonnull)layer {
  assert(layer != nil);

  if (nil == (self = [super init])) return nil;

  _layer = layer;

  return self;
}

#pragma mark Keys

- (void)setKeysToPersist:(NSArray *)keys {
  if (_keysToPersist != keys) {
    if (_keysToPersist == nil) {
      [self beginObservingAppStates];
    } else if (keys == nil) {
      [self endObservingAppStates];
    }
    _keysToPersist = keys;
  }
}

#pragma mark Animation persitence

- (void)persistAnimationAndPause {
  if (self.layer == nil) return;

  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  for (NSString *key in self.keysToPersist) {
    CAAnimation *anim = [self.layer animationForKey:key];
    if (anim != nil) {
      dict[key] = anim;
    }

  }

  if (dict.count > 0) {
    self.persistedKeysAndAnimations = dict;
    [self.layer mdx_pauseLayer];
  }
}

- (void)restoreAnimationAndResume {
  if (self.layer == nil) return;
  if (self.persistedKeysAndAnimations.count == 0) return;

  [self.persistedKeysAndAnimations enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, CAAnimation *_Nonnull anim, BOOL *_Nonnull stop) {
    [self.layer addAnimation:anim forKey:key];
  }];

  [self.layer mdx_resumeLayer];

  self.persistedKeysAndAnimations = nil;
}

#pragma mark Notifications

- (void)beginObservingAppStates {
  // when app enter background
  [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification
                                                    object:[UIApplication sharedApplication]
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification *_Nonnull note) {
    [self persistAnimationAndPause];
  }];

  // when app get reactivated
  [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification
                                                    object:[UIApplication sharedApplication]
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification *_Nonnull note) {
    [self restoreAnimationAndResume];
  }];
}

- (void)endObservingAppStates {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
