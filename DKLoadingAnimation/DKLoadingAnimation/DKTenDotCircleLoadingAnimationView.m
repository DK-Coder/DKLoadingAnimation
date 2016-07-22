//
//  DKTenDotCircleLoadingAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKTenDotCircleLoadingAnimationView.h"

@interface DKTenDotCircleLoadingAnimationView()
{
    CAReplicatorLayer *replicatorLayer;
    CALayer *dotLayer;
}
@end

@implementation DKTenDotCircleLoadingAnimationView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    replicatorLayer.position = self.center;
    dotLayer.position = CGPointMake(15, replicatorLayer.frame.size.height / 2.f);
}

- (void)sharedInit
{
//    replicatorLayer = [CAReplicatorLayer layer];
//    replicatorLayer.bounds          = CGRectMake(0, 0, 100, 100);
//    replicatorLayer.cornerRadius    = 10.0;
//    replicatorLayer.backgroundColor = [UIColor colorWithRed:.1f green:.1f blue:.1f alpha:.2f].CGColor;
//    replicatorLayer.instanceCount = 10;
//    replicatorLayer.instanceTransform = CATransform3DMakeRotation(2 * M_PI / replicatorLayer.instanceCount, 0.f, 0.f, 1.f);
//    replicatorLayer.instanceDelay = 1.f / (replicatorLayer.instanceCount * 1);
//    [self.layer addSublayer:replicatorLayer];
//    
//    dotLayer = [CALayer layer];
//    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
//    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
//    dotLayer.cornerRadius = dotLayer.bounds.size.width / 2.f;
//    dotLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
//    [replicatorLayer addSublayer:dotLayer];
    
    /*! love路径：送给丹丹 */
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 400) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0 + 250, 40)];
    [tPath addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 200) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0 - 250, 40)];
    tPath.lineCapStyle = kCGLineCapRound;//线条拐角
    tPath.lineJoinStyle = kCGLineCapRound;//终点处理
    [tPath closePath];
    
    /*! 具体的layer */
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    /*! 动作效果 */
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    CAReplicatorLayer *_loveLayer = [CAReplicatorLayer layer];
    _loveLayer.instanceCount = 40;                // 40个layer
    _loveLayer.instanceDelay = 0.2;               // 每隔0.2出现一个layer
    _loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    _loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    _loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    _loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    [_loveLayer addSublayer:tView.layer];
    
    [self.layer addSublayer:_loveLayer];
}

- (void)showWithAnimated:(BOOL)animated complete:(void (^)(BOOL))block
{
    if (animated) {
        
    } else {
        
    }
    [self moveingAnimation];
}

- (void)showWithComplete:(void (^)(BOOL))block
{
    [self showWithAnimated:YES complete:block];
}

- (void)moveingAnimation
{
//    CGFloat radius = replicatorLayer.bounds.size.width / 2.f - dotLayer.bounds.size.width;
//    CGRect frame = CGRectMake(0.f, 0.f, radius * 2, radius * 2);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
//    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    moveAnimation.path = path.CGPath;
//    moveAnimation.duration = 2.f;
////    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    moveAnimation.repeatCount = CGFLOAT_MAX;
//    [dotLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
}
@end
