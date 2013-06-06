//
//  ViewController.h
//  JWKKeyFrameAnimationView
//
//  Created by James Kelso on 6/5/13.
//  Copyright (c) 2013 James Kelso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *animationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *animationSlider;

- (IBAction)animationSwitchValueChanged:(id)sender;
- (IBAction)animationSliderValueChanged:(id)sender;

@end
