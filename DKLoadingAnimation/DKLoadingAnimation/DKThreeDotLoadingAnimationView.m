//
//  DKThreeDotLoadingAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKThreeDotLoadingAnimationView.h"

@interface DKThreeDotLoadingAnimationView()
{
    CAReplicatorLayer *replicatorLayer;
    CALayer *dotLayer;
}
@end

@implementation DKThreeDotLoadingAnimationView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    replicatorLayer.position = self.center;
    dotLayer.position = CGPointMake(15, replicatorLayer.frame.size.height / 2.f);
}

- (void)sharedInit
{
    replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds          = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius    = 10.0;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:.1f green:.1f blue:.1f alpha:.2f].CGColor;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorLayer.frame.size.width / 3.f, 0.f, 0.f);
    replicatorLayer.instanceDelay = 1.f / (replicatorLayer.instanceCount * 2);
    [self.layer addSublayer:replicatorLayer];
    
    dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = dotLayer.bounds.size.width / 2.f;
    dotLayer.transform = CATransform3DMakeScale(0, 0, 0);
    [replicatorLayer addSublayer:dotLayer];
}

- (void)showWithAnimated:(BOOL)animated complete:(void (^)(BOOL))block
{
    if (animated) {
        
    } else {
        
    }
    [self blinkAnimation];
}

- (void)showWithComplete:(void (^)(BOOL))block
{
    [self showWithAnimated:YES complete:block];
}

- (void)blinkAnimation
{
    CABasicAnimation *blinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    blinkAnimation.fromValue = @(1);
    blinkAnimation.toValue = @(0);
    blinkAnimation.duration = 1.2f;
    blinkAnimation.repeatCount = CGFLOAT_MAX;
    blinkAnimation.removedOnCompletion = NO;
    blinkAnimation.fillMode = kCAFillModeForwards;
    [dotLayer addAnimation:blinkAnimation forKey:@"blinkAnimation"];
}
@end
