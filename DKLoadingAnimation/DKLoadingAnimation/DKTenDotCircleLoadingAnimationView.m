//
//  DKTenDotCircleLoadingAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKTenDotCircleLoadingAnimationView.h"

@implementation DKTenDotCircleLoadingAnimationView

- (void)sharedInit
{
    [super sharedInit];
    
    replicatorLayer.instanceCount = 10;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(2 * M_PI / replicatorLayer.instanceCount, 0.f, 0.f, 1.f);
    replicatorLayer.instanceDelay = 2.f / (replicatorLayer.instanceCount * 2);
    [self.layer addSublayer:replicatorLayer];
    
    dotLayer.transform = CATransform3DMakeRotation(0.f, 0.f, 0.f, 1.f);
}

- (void)loadingAnimation
{
    CABasicAnimation * spinAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    spinAnimation.fromValue = @(1.0);
    spinAnimation.toValue = @(0.0);
    spinAnimation.duration = 1.f;
    spinAnimation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:spinAnimation forKey:@"loadingAnimation"];
}
@end