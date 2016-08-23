//
//  SuperViewController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/16.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "SuperViewController.h"

@implementation SuperViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configSuperViewControllerUI];
}
- (void)configSuperViewControllerUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:[UIImage imageNamed:@"backBtn_nor"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backBtn_press"] forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    backButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)backButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
