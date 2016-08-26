//
//  NightModeController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/18.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "NightModeController.h"
#import "AppDelegate.h"
@implementation NightModeController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configNightModeControllerUI];
}
- (void)configNightModeControllerUI{
    UISwitch * siwtch = [[UISwitch alloc] init];
    [siwtch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventValueChanged];
    siwtch.center = self.view.center;
    siwtch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:NIGHTMODESTATE] intValue];
    [self.view addSubview:siwtch];
}
- (void)switchClicked:(UISwitch *)swtch{
     AppDelegate * delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    //添加半透明的View放在window上
    if (swtch.on) {
        UIView * bgView = [[UIView alloc] initWithFrame:self.view.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = .3;
        bgView.tag = 1233555;
        //关闭用户交互
        bgView.userInteractionEnabled = NO;
        [delegate.window addSubview:bgView];
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:NIGHTMODESTATE];
    }else{
        for (UIView * view in delegate.window.subviews) {
            if (view.tag == 1233555) {
                [view removeFromSuperview];
                [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:NIGHTMODESTATE];
                break;
            }
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
