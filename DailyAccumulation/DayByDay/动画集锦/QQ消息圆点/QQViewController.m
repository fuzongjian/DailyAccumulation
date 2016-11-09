//
//  QQViewController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/9/20.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "QQViewController.h"
#import "BageValueButton.h"
@interface QQViewController ()

@end

@implementation QQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BageValueButton * bageValue = [BageValueButton buttonWithType:UIButtonTypeSystem];
    
    [bageValue setTitle:@"9" forState:UIControlStateNormal];
    bageValue.frame = CGRectMake(0, 0, 20, 20);
    bageValue.center = self.view.center;
    [self.view addSubview:bageValue];
    

    BageValueButton * bageValue2 = [[BageValueButton alloc] initWithFrame:CGRectMake(10, 70, 20, 20)];
    [bageValue2 setTitle:@"10" forState:UIControlStateNormal];
    [self.view addSubview:bageValue2];
    
    // Do any additional setup after loading the view.
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
