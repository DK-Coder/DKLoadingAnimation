//
//  DKAnimationView.h
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DKSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define DKSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@protocol DKAnimationDelegate <NSObject>

@required
- (void)sharedInit;
- (void)loadingAnimation;

@optional
- (void)showLoadingInView:(UIView *)view;
- (void)hideLoading;

@end

@interface DKAnimationView : UIView<DKAnimationDelegate>
{
    CAReplicatorLayer *replicatorLayer;
    CALayer *dotLayer;
}

/**
 *  圆角矩形的背景色
 */
@property (nonatomic, strong) UIColor *layerColor;

/**
 *  圆点的颜色
 */
@property (nonatomic, strong) UIColor *dotColor;
@end
