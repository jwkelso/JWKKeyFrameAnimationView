//
//  ViewController.m
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#import "JWKKeyFrameAnimationView.h"
#import "ViewController.h"

@implementation ViewController {
    JWKKeyFrameAnimationView *_frameAnimationView;
    CGFloat maxAnimationDurationSecs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up frame animation view
    UIImage *textureAtlas = [UIImage imageNamed:@"K_texture_atlas"];
	CGFloat frameWidth = 100.0f;
	CGFloat frameHeight = 100.0f;
	maxAnimationDurationSecs = 5.0f;
	NSInteger numberOfFrames = 16;
    
    _frameAnimationView = [[JWKKeyFrameAnimationView alloc] initWithFrame:CGRectMake(110, 0, frameWidth, frameHeight) textureAtlas:textureAtlas frameSize:CGSizeMake(frameWidth, frameHeight) numberOfFrames:numberOfFrames];
    _frameAnimationView.animationDuration = maxAnimationDurationSecs * self.animationSlider.value;
    [self.view addSubview:_frameAnimationView];
    _frameAnimationView.animating = YES;
}

- (IBAction)animationSwitchValueChanged:(id)sender {
    _frameAnimationView.animating = self.animationSwitch.on;
}

- (IBAction)animationSliderValueChanged:(id)sender {
    _frameAnimationView.animationDuration = maxAnimationDurationSecs * self.animationSlider.value;
}
@end
