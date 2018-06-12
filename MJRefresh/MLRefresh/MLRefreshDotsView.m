//
//  MLRefreshDotsView.m
//  MLRefresh
//
//  Created by Homway on 11/6/18.
//  Copyright © 2018 Mozat. All rights reserved.
//

#import "MLRefreshDotsView.h"

static NSString *const kScaleAnimationKey = @"kScaleAnimationKey";

@interface MLRefreshDotsView ()

@property (nonatomic, strong) CALayer *darkGrayDot;

@end

@implementation MLRefreshDotsView

+ (Class)layerClass {
	return CAReplicatorLayer.class;
}

- (void)didMoveToSuperview {
	if (self.superview) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self startAnimating];
		});
	}
}

- (CAReplicatorLayer *)replicatorLayer {
	return (CAReplicatorLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self _commonInit];
	}

	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];

	[self _commonInit];
}

- (CGSize)intrinsicContentSize {
	return CGSizeMake(40, 10);
}

#pragma mark - Private
- (void)_commonInit {
	self.backgroundColor = UIColor.clearColor;
	self.userInteractionEnabled = NO;

	CALayer *dotLayer = [CALayer layer];
	dotLayer.bounds = CGRectMake(0, 0, 10, 10);
	dotLayer.cornerRadius = 5;
	dotLayer.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;

	CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
	[replicatorLayer addSublayer:dotLayer];
	replicatorLayer.instanceCount = 3;
	replicatorLayer.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
	replicatorLayer.instanceDelay = 0.12;

	self.darkGrayDot = dotLayer;
}

#pragma mark - Public
- (void)startAnimating {
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2f :0.68f :0.18f :1.08f];
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	animation.removedOnCompletion = NO;
	animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
						 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3f, 0.3f, 1.0f)],
						 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
	animation.keyTimes = @[@0.0f, @0.3f, @1.0f];
	animation.timingFunctions = @[timingFunction, timingFunction];
	animation.duration = 0.75;
	animation.repeatCount = HUGE_VALF;
	[self.darkGrayDot addAnimation:animation forKey:kScaleAnimationKey];
}

- (void)stopAnimating {
	[self.darkGrayDot removeAnimationForKey:kScaleAnimationKey];
}

@end
