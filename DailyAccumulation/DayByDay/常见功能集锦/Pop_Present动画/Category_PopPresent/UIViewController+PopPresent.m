//
//  UIViewController+PopPresent.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/16.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "UIViewController+PopPresent.h"
#import <objc/runtime.h>
@implementation UIViewController (PopPresent)
#pragma mark --- 关键点（方法交换）
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}
#pragma mark --- Action Method

@end
