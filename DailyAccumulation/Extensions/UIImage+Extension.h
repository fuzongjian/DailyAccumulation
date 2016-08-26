//
//  UIImage+Extension.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/25.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageCornerRadius:(CGFloat)radius andSize:(CGSize)size;
- (UIImage *)imageWithColor:(UIColor *)color;
@end
