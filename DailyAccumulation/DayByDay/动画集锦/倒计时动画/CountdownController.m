//
//  CountdownController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/11/9.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CountdownController.h"
#import "CountdownView.h"
@interface CountdownController ()<CountdownViewDelegate>

@end

@implementation CountdownController

- (void)viewDidLoad {
    [super viewDidLoad];
    CountdownView * countdownView = [[CountdownView alloc] initWithFrame:self.view.bounds];
    countdownView.count = 10;
    countdownView.delegate = self;
    [self.view addSubview:countdownView];
    [countdownView start];
    // Do any additional setup after loading the view.
}
- (void)CountDownFinish{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
