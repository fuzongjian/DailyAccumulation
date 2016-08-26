//
//  BlurryController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/24.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "BlurryController.h"
@interface BlurryController ()
@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UIToolbar * tool;
@property (nonatomic,strong) UIVisualEffectView * effectView;
@end
@implementation BlurryController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configBlurryControllerUI];
}
- (void)configBlurryControllerUI{
    [self.view addSubview:self.bgImageView];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    oneButton.frame = CGRectMake(10, 74, 100, 40);
    [oneButton setTitle:@"方法一" forState:UIControlStateNormal];
    oneButton.tag = 100001;
    [oneButton addTarget: self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneButton];
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    twoButton.frame = CGRectMake(SCREEN_WIDTH - 110, 74, 100, 40);
    [twoButton setTitle:@"方法二" forState:UIControlStateNormal];
    twoButton.tag = 100002;
    [twoButton addTarget: self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoButton];
}
- (void)buttonClicked:(UIButton *)sender{
    if (sender.tag == 100001) {
        [self.effectView removeFromSuperview];
        self.effectView = nil;
        [self.bgImageView addSubview:self.tool];
    }else{
        [self.tool removeFromSuperview];
        self.tool = nil;
        [self.bgImageView addSubview:self.effectView];
    }
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _bgImageView.center = self.view.center;
        _bgImageView.image = [UIImage imageNamed:@"img"];
    }
    return _bgImageView;
}
- (UIToolbar *)tool{
    if (_tool == nil) {
        _tool = [[UIToolbar alloc] initWithFrame:self.bgImageView.bounds];
        _tool.barStyle = UIBarStyleBlack;
        _tool.alpha = 0.9;
    }
    return _tool;
}
- (UIVisualEffectView *)effectView{
    if (_effectView == nil) {
        /*注：尽量避免将UIVisualEffectView对象的alpha值设置为小于1.0的值，
         因为创建半透明的视图会导致系统在离屏渲染时去对UIVisualEffectView对象
         及所有的相关的子视图做混合操作。这不但消耗CPU/GPU，也可能会导致许多效果
         显示不正确或者根本不显示。*/
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithFrame:self.bgImageView.bounds];
        _effectView.effect = blur;
    }
    return _effectView;
}
@end
