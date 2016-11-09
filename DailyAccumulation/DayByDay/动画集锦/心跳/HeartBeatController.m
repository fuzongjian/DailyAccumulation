//
//  HeartBeatController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/9/20.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "HeartBeatController.h"

@interface HeartBeatController ()
@property (nonatomic,strong) UIImageView * heartImageView;
@end

@implementation HeartBeatController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.heartImageView];
    
    UIButton * heartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    heartButton.frame = CGRectMake(0, 64, 60, 40);
    [heartButton setTitle:@"心跳" forState:UIControlStateNormal];
    [heartButton addTarget:self action:@selector(heartAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heartButton];
    // Do any additional setup after loading the view.
}
- (void)heartAnimation:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        CABasicAnimation * animation = [CABasicAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.toValue = @0.2;
        animation.repeatCount = MAXFLOAT;
        animation.duration = 0.8;
        animation.autoreverses = YES;
        [self.heartImageView.layer addAnimation:animation forKey:nil];
    }
}
- (UIImageView *)heartImageView{
    if (_heartImageView == nil) {
        _heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _heartImageView.image = [UIImage imageNamed:@"heart"];
        _heartImageView.center = self.view.center;
    }
    return _heartImageView;
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
