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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up frame animation view
    _frameAnimationView = [[JWKKeyFrameAnimationView alloc] initWithFrame:CGRectMake(110, 0, 100, 100) textureAtlas:[UIImage imageNamed:@"K_texture_atlas"] frameSize:CGSizeMake(100, 100) numberOfFrames:16];
    _frameAnimationView.animationDuration = 5.0 * self.animationSlider.value;
    [self.view addSubview:_frameAnimationView];
    _frameAnimationView.animating = YES;
}

- (IBAction)animationSwitchValueChanged:(id)sender {
    _frameAnimationView.animating = self.animationSwitch.on;
}

- (IBAction)animationSliderValueChanged:(id)sender {
    _frameAnimationView.animationDuration = 5.0 * self.animationSlider.value;
}
@end
