//
//  DKThreeDotLoadingAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKThreeDotLoadingAnimationView.h"

@implementation DKThreeDotLoadingAnimationView

- (void)sharedInit
{
    [super sharedInit];
    
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorLayer.frame.size.width / 3.f, 0.f, 0.f);
    replicatorLayer.instanceDelay = 1.f / (replicatorLayer.instanceCount * 2);
    
    dotLayer.transform = CATransform3DMakeScale(0, 0, 0);
}

- (void)loadingAnimation
{
    CABasicAnimation *blinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    blinkAnimation.fromValue = @(1);
    blinkAnimation.toValue = @(0);
    blinkAnimation.duration = 1.2f;
    blinkAnimation.repeatCount = CGFLOAT_MAX;
    blinkAnimation.removedOnCompletion = NO;
    blinkAnimation.fillMode = kCAFillModeForwards;
    [dotLayer addAnimation:blinkAnimation forKey:@"loadingAnimation"];
}
@end
