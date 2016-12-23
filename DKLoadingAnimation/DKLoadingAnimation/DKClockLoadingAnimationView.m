//
//  DKClockLoadingAnimationView.m
//  DKLoadingAnimation
//
//  Created by xuli on 2016/12/15.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKClockLoadingAnimationView.h"

@interface DKClockLoadingAnimationView() <CAAnimationDelegate>
{
    NSTimeInterval _dk_animationDuration;
    UIBezierPath *pathInitalCircle;
    CAShapeLayer *layerInitialCircle;

    UIBezierPath *pathOuterCircle;
    CAShapeLayer *layerOuterCircle;
    
    CAShapeLayer *layerWaterDrop;
    
    UIBezierPath *pathInner;
    
    CGRect frameForWaterDrop;
    
    CAShapeLayer *layerClockInside;
    CAShapeLayer *layerCenterDot;
    CAShapeLayer *layerHourHand;
    
    CGPoint pathCurrentPoint;/**< 存储path的最后一个点位置*/
}
@end

@implementation DKClockLoadingAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];

        self.hidden = YES;
    }
    
    return self;
}

- (void)sharedInit
{
    _dk_backgroundColor = [UIColor blackColor];
    _dk_mainColor = [UIColor colorWithRed:78.f / 255.f green:176.f / 255.f blue:185.f / 255.f alpha:1.f];
    _dk_animationDuration = 5;
    _dk_outerRadius = CGRectIsNull(self.frame) || CGRectIsEmpty(self.frame) ? 200.f : self.frame.size.width * .75f / 2.f;
    _dk_innerRadius = _dk_outerRadius * .5f;
    _dk_lineWidth = 8.f;
    
    self.backgroundColor = self.dk_backgroundColor;
    
    
//    pathInitalCircle = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:_dk_lineWidth / 2.f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    layerInitialCircle = [CAShapeLayer layer];
//    layerInitialCircle.frame = CGRectMake((self.frame.size.width - _dk_lineWidth * 2) / 2.f, self.center.y - _dk_outerRadius, _dk_lineWidth, _dk_lineWidth);
//    layerInitialCircle.path = pathInitalCircle.CGPath;
//    layerInitialCircle.fillColor = _dk_mainColor.CGColor;
//    [self.layer addSublayer:layerInitialCircle];
    
    pathOuterCircle = [UIBezierPath bezierPathWithArcCenter:self.center radius:_dk_outerRadius startAngle:M_PI * 1.5f endAngle:M_PI * 1.499f clockwise:YES];
    layerOuterCircle = [CAShapeLayer layer];
//    layerOuterCircle.frame = CGRectMake(0.f, 0.f, _dk_outerRadius * 2, _dk_outerRadius * 2);
    layerOuterCircle.path = pathOuterCircle.CGPath;
    layerOuterCircle.lineWidth = _dk_lineWidth;
    layerOuterCircle.strokeColor = _dk_mainColor.CGColor;
    layerOuterCircle.lineCap = kCALineCapRound;
    layerOuterCircle.lineJoin = kCALineJoinRound;
    layerOuterCircle.strokeStart = 0.f;
    layerOuterCircle.strokeEnd = 0.001f;
    [self.layer addSublayer:layerOuterCircle];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(layerOuterCircle.strokeEnd);
    animation.byValue = @(1.f);
    animation.duration = _dk_animationDuration / 5.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layerOuterCircle addAnimation:animation forKey:nil];
    
    CGFloat widthForWaterDrop = _dk_lineWidth;
    CGFloat heightForWaterDrop = _dk_lineWidth + 2.f;
    frameForWaterDrop = CGRectMake(self.center.x - widthForWaterDrop / 2.f, self.center.y - _dk_outerRadius - heightForWaterDrop / 2.f, widthForWaterDrop, heightForWaterDrop);
    UIBezierPath *pathWaterDrop = [UIBezierPath bezierPathWithOvalInRect:frameForWaterDrop];
    layerWaterDrop = [CAShapeLayer layer];
//    layerWaterDrop.frame = CGRectMake(0.f, 0.f, frameForWaterDrop.size.width, 0.f);
    layerWaterDrop.path = pathWaterDrop.CGPath;
    layerWaterDrop.fillColor = _dk_mainColor.CGColor;
    layerWaterDrop.opacity = 0.f;
    [layerOuterCircle addSublayer:layerWaterDrop];
    
    CABasicAnimation *animationOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationOpacity.toValue = @(1.f);
    animationOpacity.duration = _dk_animationDuration / 5.f / 3.f;
//    animationBounds.beginTime = animation.duration + CACurrentMediaTime();
    animationOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationOpacity.fillMode = kCAFillModeForwards;
    animationOpacity.removedOnCompletion = NO;
//    [layerWaterDrop addAnimation:animationBounds forKey:nil];
    
    CABasicAnimation *animationPosition = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animationPosition.byValue = @(_dk_innerRadius * 3.f);
    animationPosition.duration = _dk_animationDuration * .2f;
//    animationPosition.beginTime = animation.duration + animationBounds.duration + CACurrentMediaTime();
    animationPosition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationPosition.fillMode = kCAFillModeForwards;
    animationPosition.removedOnCompletion = NO;
//    [layerWaterDrop addAnimation:animationForWaterDrop forKey:nil];
    
    CAAnimationGroup *animationGroupForWaterDrop = [CAAnimationGroup animation];
    animationGroupForWaterDrop.animations = @[animationOpacity, animationPosition];
    animationGroupForWaterDrop.beginTime = animation.duration + CACurrentMediaTime();
    animationGroupForWaterDrop.duration = _dk_animationDuration / 5.f;
    animationGroupForWaterDrop.fillMode = kCAFillModeForwards;
    animationGroupForWaterDrop.removedOnCompletion = NO;
    animationGroupForWaterDrop.delegate = self;
    [layerWaterDrop addAnimation:animationGroupForWaterDrop forKey:@"waterDropGroupAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([layerWaterDrop animationForKey:@"waterDropGroupAnimation"] == anim) {
        if (flag) {
            [layerWaterDrop removeFromSuperlayer];
            
            UIBezierPath *pathClockInside = [UIBezierPath bezierPathWithArcCenter:self.center radius:_dk_innerRadius startAngle:M_PI * .5f endAngle:M_PI * 1.45f clockwise:YES];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:0.f offsetY:-15.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:-10.f offsetY:0.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:0.f offsetY:-15.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:45.f offsetY:0.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:0.f offsetY:15.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:-10.f offsetY:0.f]];
            [pathClockInside addLineToPoint:[self generatePathPointWithInPath:pathClockInside offsetX:0.f offsetY:15.f]];
            [pathClockInside addArcWithCenter:self.center radius:_dk_innerRadius startAngle:M_PI * 1.6f endAngle:M_PI * .499f clockwise:YES];
            pathCurrentPoint = pathClockInside.currentPoint;
            layerClockInside = [CAShapeLayer layer];
            layerClockInside.path = pathClockInside.CGPath;
            layerClockInside.strokeColor = _dk_mainColor.CGColor;
            layerClockInside.lineWidth = _dk_lineWidth;
            layerClockInside.lineCap = kCALineCapRound;
            layerClockInside.lineJoin = kCALineJoinRound;
            layerClockInside.strokeStart = 0.f;
            layerClockInside.strokeEnd = 1.f;
            [layerOuterCircle addSublayer:layerClockInside];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = @(.01f);
            animation.toValue = @(1.f);
            animation.duration = _dk_animationDuration / 5.f;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            animation.delegate = self;
            [layerClockInside addAnimation:animation forKey:@"clockInsideAnimation"];
        }
    } else if ([layerClockInside animationForKey:@"clockInsideAnimation"] == anim) {
        if (flag) {
            UIBezierPath *pathCenter = [UIBezierPath bezierPathWithArcCenter:self.center radius:5.f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            layerCenterDot = [CAShapeLayer layer];
            layerCenterDot.path = pathCenter.CGPath;
            layerCenterDot.fillColor = _dk_mainColor.CGColor;
            layerCenterDot.opacity = 0.f;
            [layerOuterCircle addSublayer:layerCenterDot];
            pathCurrentPoint = pathCenter.currentPoint;
            
            CABasicAnimation *animationOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animationOpacity.toValue = @(1.f);
            animationOpacity.duration = .5;
            animationOpacity.fillMode = kCAFillModeForwards;
            animationOpacity.removedOnCompletion = NO;
            animationOpacity.delegate = self;
            [layerCenterDot addAnimation:animationOpacity forKey:@"centerDotOpacityAnimation"];
        }
    } else if ([layerCenterDot animationForKey:@"centerDotOpacityAnimation"] == anim) {
        if (flag) {
            UIBezierPath *pathHourHand = [UIBezierPath bezierPath];
            [pathHourHand moveToPoint:self.center];
            [pathHourHand addLineToPoint:CGPointMake(pathCurrentPoint.x + _dk_innerRadius * .5f, pathCurrentPoint.y - _dk_innerRadius * .5f)];
            layerHourHand = [CAShapeLayer layer];
            layerHourHand.path = pathHourHand.CGPath;
            layerHourHand.lineWidth = _dk_lineWidth;
            layerHourHand.lineCap = kCALineCapRound;
            layerHourHand.lineJoin = kCALineJoinRound;
            layerHourHand.strokeColor = _dk_mainColor.CGColor;
            layerHourHand.strokeStart = 0.f;
            layerHourHand.strokeEnd = 1.f;
            layerHourHand.anchorPoint = CGPointMake(0.f, 0.f);
            [layerOuterCircle addSublayer:layerHourHand];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = @(0.1f);
            animation.toValue = @(1.f);
            animation.duration = .5f;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            
            CABasicAnimation *animationRotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animationRotate.byValue = @(M_PI_2);
            animationRotate.beginTime = animation.duration;
            animationRotate.fillMode = kCAFillModeForwards;
            animationRotate.removedOnCompletion = NO;
            
            CAAnimationGroup *hourHandAnimationGroup = [CAAnimationGroup animation];
            hourHandAnimationGroup.animations = @[animation, animationRotate];
            hourHandAnimationGroup.duration = 4.f;
            hourHandAnimationGroup.fillMode = kCAFillModeForwards;
            hourHandAnimationGroup.removedOnCompletion = NO;
            [layerHourHand addAnimation:hourHandAnimationGroup forKey:nil];
        }
    }
}

- (CGPoint)generatePathPointWithInPath:(UIBezierPath *)path offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY
{
    return CGPointMake(path.currentPoint.x + offsetX, path.currentPoint.y + offsetY);
}
@end
