//
//  UINavigationController+PopPresent.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/16.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopPresentConfig.h"
@interface UINavigationController (PopPresent)
- (void)popPresent_pushViewController:(UIViewController *)viewController animationType:(TransitionAnimationType)animationType;
@end
