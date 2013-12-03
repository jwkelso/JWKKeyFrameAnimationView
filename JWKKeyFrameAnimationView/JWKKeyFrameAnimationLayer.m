//
//  JWKKeyFrameAnimationLayer.m
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#import "JWKKeyFrameAnimationLayer.h"

#define KEY_FRAME_ANIMATION_KEY @"KeyFrameAnimationKey"

@implementation JWKKeyFrameAnimationLayer {
    CABasicAnimation *_animation;
    NSCache *_imageCache;
    BOOL _animating;
}

-(instancetype)initWithImage:(CGImageRef)img frameSize:(CGSize)size {
    self = [super init];
    if (self) {
        _textureAtlas = img;
        
        // Subscribe to foreground/background events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        
        // Set layer contents to texture atlas
        self.contents = (__bridge id)img;
        // Set anchor point to top left
        self.anchorPoint = CGPointZero;
        // Start at the first frame of the animation
        self.frameIndex = 0;
        
        // Set bounds to the key frame size, and the contents rect to the first key frame
        CGFloat scaleFactor = [[UIScreen mainScreen] scale];
        CGFloat normalizedWidth = size.width * scaleFactor / CGImageGetWidth(img);
        CGFloat normalizedHeight = size.height * scaleFactor /CGImageGetHeight(img);
        CGSize sampleSizeNormalized = CGSizeMake(normalizedWidth, normalizedHeight);
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        self.contentsRect = CGRectMake(0, 0, sampleSizeNormalized.width, sampleSizeNormalized.height);
        
        // Add an animation to the view
        _animation = [CABasicAnimation animationWithKeyPath:@"frameIndex"];
        _animation.fromValue = [NSNumber numberWithInt:0];
        _animation.toValue = [NSNumber numberWithInt:self.numberOfFrames];
        _animation.duration = 1.0;
        _animation.repeatCount = HUGE_VALF;
        _animation.autoreverses = NO;
    }
    return self;
}

-(void)setAnimationDuration:(CGFloat)animationDuration {
    // Control the animation duration by varying the layer timing speed.
    // The speed should be the inverse of the duration.
    _animationDuration = animationDuration;
    if (_animating) {
        self.speed = _animation.duration / animationDuration;
    }
}

-(void)setNumberOfFrames:(NSInteger)numberOfFrames {
    _numberOfFrames = numberOfFrames;
    _animation.toValue = [NSNumber numberWithInt:self.numberOfFrames];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - CALayer methods
+(id)defaultActionForKey:(NSString *)key {
    // Turn off animation of bounds or contents rect resizing
    if ([key isEqualToString:@"contentsRect"] || [key isEqualToString:@"bounds"]) {
        return [NSNull null];
    }
    return [super defaultActionForKey:key];
}

-(void)display {
    // All a CALayerDelegate to override drawing
    if ([self.delegate respondsToSelector:@selector(displayLayer:)]) {
        [self.delegate displayLayer:self];
        return;
    }
    
    // Otherwise, move the content rect to the next frame
    NSInteger keyFrameIndex = [[self presentationLayer] frameIndex];
    CGSize sizeOfKeyFrame = self.contentsRect.size;
    CGFloat keyFrameOriginX = (keyFrameIndex % (NSInteger)(1/sizeOfKeyFrame.width)) * sizeOfKeyFrame.width;
    CGFloat keyFrameOriginY = ((keyFrameIndex)/(NSInteger)(1/sizeOfKeyFrame.width)) * sizeOfKeyFrame.height;
    self.contentsRect = CGRectMake(keyFrameOriginX, keyFrameOriginY, sizeOfKeyFrame.width, sizeOfKeyFrame.height);
}

+(BOOL)needsDisplayForKey:(NSString *)key {
    // Automatically redraw when frameIndex is changed
    return [key isEqualToString:@"frameIndex"];
}

#pragma mark - Public methods
-(void)startFrameAnimation {
    _animating = YES;
    if ([[self animationKeys] count] == 0) {
        [self addAnimation:_animation forKey:KEY_FRAME_ANIMATION_KEY];
    }
    
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = _animation.duration / self.animationDuration;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
    
}

-(void)stopFrameAnimation {
    _animating = NO;
    
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

#pragma mark - Private methods
// Restart animation when coming back from background
-(void)applicationDidBecomeActive:(NSNotification *)notification {
    if (!_animating) {
        return;
    }
    [self startFrameAnimation];
}

// Pause animation when not active
-(void)applicationWillResignActive:(NSNotification *)notification {
    if (!_animating) {
        return;
    }
    [self stopFrameAnimation];
}

@end
