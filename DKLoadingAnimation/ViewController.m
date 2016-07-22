//
//  ViewController.m
//  DKLoadingAnimation
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "ViewController.h"
#import "DKThreeDotLoadingAnimationView.h"
#import "DKTenDotCircleLoadingAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 100.f, self.view.frame.size.width, 60.f)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"loading遮挡测试" forState:UIControlStateNormal];
    [btn setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:btn];
    
    CGRect frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
//    DKThreeDotLoadingAnimationView *loading = [[DKThreeDotLoadingAnimationView alloc] init];
//    loading.frame = frame;
//    [self.view addSubview:loading];
//    [loading showWithComplete:nil];
    
    DKTenDotCircleLoadingAnimationView *loading2 = [[DKTenDotCircleLoadingAnimationView alloc] init];
    loading2.frame = frame;
    [self.view addSubview:loading2];
    [loading2 showWithComplete:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
