//
//  CustomMenuController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CustomMenuController.h"
#define NUMBERLINES 3
#define ITEMW 80
#define MARGIN (self.view.bounds.size.width - NUMBERLINES * ITEMW)/(NUMBERLINES + 1)
@implementation MenuItem
@end
@interface CustomMenuController ()

@end

@implementation CustomMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self configCustomMenuControllerUI];
}
- (void)configCustomMenuControllerUI{
    //手势添加
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked:)]];
    //毛玻璃效果
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    //布局items
    for (NSInteger i = 0; i < self.menuItemArray.count; i ++) {
        NSInteger row = i / NUMBERLINES;
        NSInteger loc = i % NUMBERLINES;
        CGFloat itemX = MARGIN + (MARGIN + ITEMW) * loc;
        CGFloat itemY = 100 + (50 + ITEMW) * row;
        //button
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame = CGRectMake(itemX, - 300, ITEMW, ITEMW);
        itemButton.tag = i;
        [itemButton addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:itemButton];
        //lable
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(itemX, itemButton.bottom + 5, ITEMW, 25)];
        lable.textColor = [UIColor grayColor];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.tag = i;
        [self.view addSubview:lable];
        
        MenuItem * item = [self.menuItemArray objectAtIndex:i];
        [itemButton setImage:item.icon forState:UIControlStateNormal];
        lable.text = item.title;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.f delay:(0.2 - 0.02 * i) usingSpringWithDamping:1.f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                itemButton.frame = CGRectMake(itemX, itemY, ITEMW, ITEMW);
                lable.frame = CGRectMake(itemX, itemButton.bottom + 5, ITEMW, 25);
            } completion:nil];
        });
        
        
    }
    
    
}
- (void)tapGestureClicked:(UITapGestureRecognizer *)tap{
    [self dismissAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(customMenuDidTapClickBackground)]) {
            [_delegate customMenuDidTapClickBackground];
        }
    });
}
- (void)itemButtonClicked:(UIButton *)sender{
    [UIView animateWithDuration:.25 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.7, 1.7);
    }];
    [self dismissAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_delegate&&[_delegate respondsToSelector:@selector(customMenuDidTapOnItem:)]) {
            [_delegate customMenuDidTapOnItem:self.menuItemArray[sender.tag]];
        }
    });
}
- (void)dismissAnimation{
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                /* 
                 spring animation
                 usingSpringWithDamping 的范围是0.0f到1.f，数值越小，弹簧效果越明显
                 initialSpringVelocity 表示初始速度，数值越大一开始移动越快
                 */
                [UIView animateWithDuration:1.f delay:0.02 * (button.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    button.frame = CGRectMake(button.left, -300, button.width, button.height);
                } completion:nil];
            });
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel * lable = (UILabel *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.f delay:.02*(lable.tag) usingSpringWithDamping:.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    lable.textColor = [UIColor clearColor];
                } completion:nil];
            });
        }
    }
}
- (instancetype)initWithMenuItems:(NSArray *)menuItems{
    if (self = [super init]) {
        self.menuItemArray = menuItems;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
