//
//  ViewController.m
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "SettingViewController.h"
#import "HFSegmentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";

    SettingViewController *settingVC = [[SettingViewController alloc] init];
    settingVC.title = @"设置";
    
    HFSegmentView *segmentView = [[HFSegmentView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) titleHeight:44.f viewControllers:@[homeVC, settingVC]];
    
    [self.view addSubview:segmentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
