//
//  MLDotsRefreshFooter.m
//  MLRefresh
//
//  Created by Homway on 12/6/18.
//  Copyright © 2018 Mozat. All rights reserved.
//

#import "MLDotsRefreshFooter.h"
#import "MLRefreshDotsView.h"

@interface MLDotsRefreshFooter ()

@property (nonatomic, strong) MLRefreshDotsView *dotsView;

@end

@implementation MLDotsRefreshFooter

- (MLRefreshDotsView *)dotsView {
	if (!_dotsView) {
		_dotsView = [[MLRefreshDotsView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
		[self addSubview:_dotsView];
	}

	return _dotsView;
}

- (void)placeSubviews {
	[super placeSubviews];

	self.dotsView.center = CGPointMake(self.mj_w / 2.0, self.mj_h / 2.0);
}

- (void)setState:(MJRefreshState)state {
	MJRefreshCheckState

	if (state == MJRefreshStatePulling) {
		self.dotsView.hidden = NO;
	} else if (state == MJRefreshStateRefreshing) {
		self.dotsView.hidden = NO;
		[self.dotsView startAnimating];
	} else if (state == MJRefreshStateIdle) {
		self.dotsView.hidden = YES;
		[self.dotsView stopAnimating];
	}
}

@end
