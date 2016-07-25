//
//  DKAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKAnimationView.h"

@implementation DKAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
        
        self.hidden = YES;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    replicatorLayer.position = self.center;
    dotLayer.position = CGPointMake(15, replicatorLayer.frame.size.height / 2.f);
}

- (void)sharedInit
{
    self.frame = CGRectMake(0.f, 0.f, DKSCREEN_WIDTH, DKSCREEN_HEIGHT);
    
    replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds          = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius    = 10.0;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:.1f green:.1f blue:.1f alpha:.2f].CGColor;
    [self.layer addSublayer:replicatorLayer];
    
    dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = dotLayer.bounds.size.width / 2.f;
    [replicatorLayer addSublayer:dotLayer];
}

- (void)loadingAnimation
{
    
}

- (void)showLoadingInView:(UIView *)view
{
    [view addSubview:self];
    [self animationWithHidden:NO];
    [self loadingAnimation];
}

- (void)hideLoading
{
    [self animationWithHidden:YES];
    [dotLayer removeAnimationForKey:@"loadingAnimation"];
    [self removeFromSuperview];
}

- (void)animationWithHidden:(BOOL)hidden
{
    [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.hidden = hidden;
    } completion:nil];
}

- (void)setLayerColor:(UIColor *)layerColor
{
    replicatorLayer.backgroundColor = layerColor.CGColor;
}

- (void)setDotColor:(UIColor *)dotColor
{
    dotLayer.backgroundColor = dotColor.CGColor;
}
@end
