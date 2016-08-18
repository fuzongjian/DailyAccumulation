//
//  AreaPickerController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/18.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "AreaPickerController.h"
#import "AreaPickerView.h"
@interface AreaPickerController ()
@property (nonatomic,strong) UILabel * displayLable;
@end
@implementation AreaPickerController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configAreaPickerControllerUI];
}
- (void)configAreaPickerControllerUI{
    [self.view addSubview:self.displayLable];
    
    [AreaPickerView showOnView:self.view completion:^(NSString *province, NSString *city, NSString *area) {
        if (area.length) {
            self.displayLable.text = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
        }else{
            self.displayLable.text = [NSString stringWithFormat:@"%@-%@",province,city];
        }
    }];
    
    
}
- (UILabel *)displayLable{
    if (_displayLable == nil) {
        _displayLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 40)];
        _displayLable.textAlignment = NSTextAlignmentCenter;
        _displayLable.textColor = [UIColor blueColor];
        _displayLable.font = [UIFont systemFontOfSize:20];
        _displayLable.text = @"四川省-成都市-金牛区";
    }
    return _displayLable;
}
@end
