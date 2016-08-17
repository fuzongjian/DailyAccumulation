//
//  PasswordController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "PasswordController.h"
#import "PasswordView.h"
@implementation PasswordController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configPasswordControllerUI];
}
- (void)configPasswordControllerUI{
    [PasswordView showOnView:self.view completion:^(NSString *password) {
        NSLog(@"%@",password);
    }];
}
@end
