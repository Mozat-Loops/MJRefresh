//
//  MLLogoRefreshHeader.m
//  MLRefresh
//
//  Created by Homway on 11/6/18.
//  Copyright © 2018 Mozat. All rights reserved.
//

#import "MLLogoRefreshHeader.h"

static NSArray *LogoImages = nil;

@implementation MLLogoRefreshHeader

+ (void)initialize {
	[super initialize];

	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:40];
	for (NSInteger i = 0; i <= 39; i++) {
		NSString *imageName = [NSString stringWithFormat:@"homeloading_%02ld", i];
		UIImage *logoImage = [UIImage imageNamed:imageName];
		if (logoImage) {
			[temp addObject:logoImage];
		}
	}

	LogoImages = [temp copy];
}

- (void)prepare {
	[super prepare];

	[self setImages:LogoImages duration:2 forState:MJRefreshStateRefreshing];
	[self setImages:@[LogoImages.lastObject] forState:MJRefreshStatePulling];
	self.lastUpdatedTimeLabel.hidden = YES;
	self.stateLabel.hidden = YES;
}

@end
