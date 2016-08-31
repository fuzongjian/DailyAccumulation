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
@end
@implementation CornerRadiusController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configCornerRadiusControllerUI];
}
- (void)configCornerRadiusControllerUI{
    [self.view addSubview:self.bgImageView];
    self.bgImageView.image = [self.bgImageView.image imageCornerRadius:5 andSize:self.bgImageView.bounds.size];
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _bgImageView.center = self.view.center;
        _bgImageView.image = [UIImage imageNamed:@"img"];
    }
    return _bgImageView;
}
@end
