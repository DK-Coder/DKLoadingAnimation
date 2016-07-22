//
//  DKAnimationView.h
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DKAnimationType) {
    DKAnimationTypeFadeIn = 0
};

@protocol DKAnimationDelegate <NSObject>

@required
- (void)sharedInit;

@optional
- (void)showWithAnimated:(BOOL)animated complete:(void (^)(BOOL finish))block;
- (void)showWithComplete:(void (^)(BOOL finish))block;

@end

@interface DKAnimationView : UIView<DKAnimationDelegate>

@property (nonatomic, assign) DKAnimationType animationType;
@end
