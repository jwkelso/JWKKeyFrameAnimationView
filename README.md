JWKKeyFrameAnimationView
========================
JWKKeyFrameAnimationView will allow you to create a view that displays a key-frame animation from a texture atlas. Currently, all frames must be of uniform size.

This class will allow you to do animations that CATransforms will not. It works great for creating custom spinners.

![Frame Animation Example](http://i.imgur.com/oJptCfv.gif)![Texture Atlas Example](http://i.imgur.com/8ayBGqH.png)

Usage:

	// Set up frame animation view
	UIImage *textureAtlas = [UIImage imageNamed:@"K_texture_atlas"];
	CGFloat frameWidth = 100.0f;
	CGFloat frameHeight = 100.0f;
	CGFloat animationDurationSecs = 5.0f;
	NSInteger numberOfFrames = 16;
	
	JWKKeyFrameAnimationView *frameAnimationView = [[JWKKeyFrameAnimationView alloc] 
		initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)
		textureAtlas:textureAtlas 
		frameSize:CGSizeMake(frameWidth, frameHeight) 
	    numberOfFrames:numberOfFrames];
	frameAnimationView.animationDuration = animationDurationSecs;
	[self.view addSubview:frameAnimationView];
	frameAnimationView.animating = YES;
