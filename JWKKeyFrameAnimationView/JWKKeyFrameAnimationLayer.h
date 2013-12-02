//
//  JWKKeyFrameAnimationLayer.h
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#define FILE_NAME @"textureAtlasName"
#define KEY_FRAME_HEIGHT @"keyFrameHeight"
#define KEY_FRAME_WIDTH @"keyFrameWidth"
#define NUMBER_OF_FRAMES @"numberOfFrames"
#define ORIGIN_X @"originX"
#define ORIGIN_Y @"originY"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface JWKKeyFrameAnimationLayer : CALayer {
    CGImageRef _textureAtlas;
}

@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) NSInteger frameIndex;
@property (nonatomic) NSInteger numberOfFrames;
@property (readonly) CABasicAnimation *animation;

-(instancetype)initWithImage:(CGImageRef)img frameSize:(CGSize)size;
-(void)startFrameAnimation;
-(void)stopFrameAnimation;

@end
