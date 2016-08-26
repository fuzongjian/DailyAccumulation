//
//  AreaPickerView.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/18.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "AreaPickerView.h"
#define PICKERVIEW_HEIGHT 150
@interface AreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,copy) completionBlock completion;
@property (nonatomic,strong) UIPickerView * areaPicker;//选择器
@property (nonatomic,strong) NSArray * provinceArray;//省
@property (nonatomic,strong) NSArray * cityArray;//市
@property (nonatomic,strong) NSArray * areaArray;//县
@property (nonatomic,copy) NSString * selectedProvince;
@property (nonatomic,copy) NSString * selectedCity;
@property (nonatomic,copy) NSString * selectedArea;
@end
static AreaPickerView * areaPickerView;
@implementation AreaPickerView

+ (void)showOnView:(UIView *)view completion:(completionBlock)completion{
    areaPickerView  = [[AreaPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) completion:completion];
    areaPickerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    [view addSubview:areaPickerView];
}
- (instancetype)initWithFrame:(CGRect)frame completion:(completionBlock)completion{
    if (self = [super initWithFrame:frame]) {
        [self configAreaPickerViewUI];
        self.completion = completion;
    }
    return self;
}
- (void)configAreaPickerViewUI{
    self.provinceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    self.cityArray = [NSArray arrayWithArray:self.provinceArray[0][@"cities"]];
    self.areaArray = [NSArray arrayWithArray:self.cityArray[0][@"areas"]];
    self.selectedProvince = self.provinceArray[0][@"state"];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked:)];
    [self addGestureRecognizer:tapGesture];
    [self addSubview:self.areaPicker];
}
#pragma mark --- UIPickerView Delegate Method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArray.count;
            break;
        case 1:
            return self.cityArray.count;
            break;
        case 2:
            if (self.areaArray == nil) {
                return 0;
            }
            return self.areaArray.count;
            break;
        default:
            break;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArray[row][@"state"];
            break;
        case 1:
            return self.cityArray[row][@"city"];
            break;
        case 2:
            return self.areaArray[row];
            break;
        default:
            break;
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.selectedProvince = self.provinceArray[row][@"state"];
            self.cityArray = self.provinceArray[row][@"cities"];
            [pickerView reloadComponent:1];
            if (self.cityArray.count > 0) {
                self.selectedCity = self.cityArray[0][@"city"];
            }
            [pickerView selectRow:0 inComponent:1 animated:NO];
            
            self.areaArray = self.cityArray[0][@"areas"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            if (self.areaArray.count > 0) {
                self.selectedArea = self.areaArray[0];
            }else{
                self.selectedArea = @"";
            }
            break;
        case 1:
            self.selectedCity = self.cityArray[row][@"city"];
            self.areaArray = self.cityArray[row][@"areas"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            if (self.areaArray.count > 0) {
                self.selectedArea = self.areaArray[0];
            }
            break;
        case 2:
            self.selectedArea = self.areaArray.count > 0 ? self.areaArray[row]:@"";
            break;
        default:
            break;
    }
    self.completion(self.selectedProvince,self.selectedCity,self.selectedArea);
}
#pragma mark --- Action Method
- (void)tapGestureClicked:(UITapGestureRecognizer *)tapGesture{
    [UIView animateWithDuration:0.5f animations:^{
        areaPickerView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        areaPickerView.alpha = 0;
    } completion:^(BOOL finished) {
        [areaPickerView removeFromSuperview];
    }];
}
#pragma mark --- lazy Method
- (UIPickerView *)areaPicker{
    if (_areaPicker == nil) {
        _areaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
        _areaPicker.backgroundColor = [UIColor whiteColor];
        _areaPicker.delegate = self;
        _areaPicker.dataSource = self;
    }
    return _areaPicker;
}
@end
