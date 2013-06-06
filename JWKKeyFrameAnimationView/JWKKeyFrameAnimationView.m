//
//  JWKKeyFrameAnimationView.m
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#import "JWKKeyFrameAnimationLayer.h"
#import "JWKKeyFrameAnimationView.h"

@implementation JWKKeyFrameAnimationView {
    JWKKeyFrameAnimationLayer *_animationLayer;
}

-(instancetype)initWithFrame:(CGRect)frame textureAtlas:(UIImage *)textureAtlas frameSize:(CGSize)frameSize numberOfFrames:(CGFloat)numberOfFrames {
    self = [super initWithFrame:frame];
    if (self) {
        _textureAtlas = textureAtlas;
        _frameSize = frameSize;
        _numberOfFrames = numberOfFrames;
        
        _animationLayer = [[JWKKeyFrameAnimationLayer alloc] initWithImage:_textureAtlas.CGImage frameSize:_frameSize];
        _animationLayer.numberOfFrames = _numberOfFrames;
        [self.layer addSublayer:_animationLayer];
        [_animationLayer setNeedsDisplay];
    }
    return self;
}

#pragma mark - Overridden setters
-(void)setAnimating:(BOOL)animating {
    _animating = animating;
    if (animating) {
        [_animationLayer startFrameAnimation];
    }
    else {
        [_animationLayer stopFrameAnimation];
    }
}

-(void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    _animationLayer.animationDuration = animationDuration;
}
@end
