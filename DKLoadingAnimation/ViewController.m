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

@interface ViewController()
{
    NSArray *arrayLoadingAnimations;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    DKThreeDotLoadingAnimationView *loading = [[DKThreeDotLoadingAnimationView alloc] init];
//    loading.frame = self.view.frame;
//    [self.view addSubview:loading];
//    [loading showLoading];
    
//    DKTenDotCircleLoadingAnimationView *loading2 = [[DKTenDotCircleLoadingAnimationView alloc] init];
//    loading2.frame = self.view.frame;
//    [self.view addSubview:loading2];
//    [loading2 showLoading];
    [self initAllData];
    [self initAllControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initAllData
{
    arrayLoadingAnimations = @[@"DKThreeDotLoadingAnimationView", @"DKTenDotCircleLoadingAnimationView"];
}

- (void)initAllControls
{
    UITableView *tableDemo = [[UITableView alloc] initWithFrame:self.view.frame];
    tableDemo.delegate = self;
    tableDemo.dataSource = self;
    tableDemo.rowHeight = 50.f;
    tableDemo.tableFooterView = [UIView new];
    [self.view addSubview:tableDemo];
    [tableDemo registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
}

#pragma UITableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayLoadingAnimations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    cell.textLabel.text = arrayLoadingAnimations[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class className = NSClassFromString(arrayLoadingAnimations[indexPath.row]);
    DKAnimationView *loadingAnimation = [className new];
//    loadingAnimation.dotColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.f green:arc4random_uniform(256) / 255.f blue:arc4random_uniform(256) / 255.f alpha:1.f];
    [loadingAnimation showLoadingInView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loadingAnimation hideLoading];
    });
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
