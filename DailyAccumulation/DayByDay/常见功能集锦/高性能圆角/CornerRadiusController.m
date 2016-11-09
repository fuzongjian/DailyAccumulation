//
//  CornerRadiusController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/25.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CornerRadiusController.h"
@interface CornerRadiusController ()
@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UISegmentedControl * segmentControl;
@end
@implementation CornerRadiusController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configCornerRadiusControllerUI];
}
- (void)configCornerRadiusControllerUI{
    
    [self.view addSubview:self.segmentControl];
//    [self firstMethod];
//    self.bgImageView.customRadius = 20;
    [self thirdMethod];
    
}
- (void)segmentControlClicked:(UISegmentedControl *)seg{
    [self.bgImageView removeFromSuperview];
    self.bgImageView = nil;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self firstMethod];
            break;
        case 1:
            [self secondMethod];
            break;
        case 2:
            [self thirdMethod];
            break;
        default:
            break;
    }
}
/**
 *  @brief 通过设置layer的属性，很影响性能，一般开发中很少用到。
 */
- (void)firstMethod{
    self.bgImageView.layer.cornerRadius = 5;
    self.bgImageView.layer.masksToBounds = YES;
}
/**
 *  @brief 使用CAshapeLayer和UIBezierPath设置圆角 这一种效果最好，内存消耗最少，渲染速度快，从长远的角度第三种最优
 */
- (void)secondMethod{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bgImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    //设置大小
    maskLayer.frame = self.bgImageView.bounds;
    //设置图形样式
    maskLayer.path = bezierPath.CGPath;
    self.bgImageView.layer.mask = maskLayer;
}
/**
 *  @brief 使用贝塞尔曲UIBezierPath和Core Graphics框架画出一个圆角
 */
- (void)thirdMethod{
    self.bgImageView.image = [self.bgImageView.image imageCornerRadius:15 andSize:self.bgImageView.bounds.size];
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _bgImageView.center = self.view.center;
        _bgImageView.image = [UIImage imageNamed:@"img"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}
- (UISegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        NSArray * items = @[@"第一种",@"第二种",@"第三种"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentControl.frame = CGRectMake(10, 70, SCREEN_WIDTH - 20, 35);
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(segmentControlClicked:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentControl;
}
@end
