//
//  JWKKeyFrameAnimationView.h
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWKKeyFrameAnimationLayer;

@interface JWKKeyFrameAnimationView : UIView {
    CGSize _frameSize;
    NSInteger _numberOfFrames;
    UIImage *_textureAtlas;
}

@property (nonatomic) BOOL animating;
@property (nonatomic) CGFloat animationDuration;
@property (readonly) JWKKeyFrameAnimationLayer *animationLayer;

-(instancetype)initWithFrame:(CGRect)frame textureAtlas:(UIImage *)textureAtlas frameSize:(CGSize)frameSize numberOfFrames:(CGFloat)numberOfFrames;

@end
