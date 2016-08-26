//
//  UIView+Extension.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/25.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//只读属性
@property (nonatomic,readonly) CGPoint bottomLeft;
@property (nonatomic,readonly) CGPoint bottomRight;
@property (nonatomic,readonly) CGPoint topRight;
//可读可写属性
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
/**相当于x属性*/
@property (nonatomic,assign) CGFloat left;
/**相当于y属性*/
@property (nonatomic,assign) CGFloat top;
/**相当于top＋height属性*/
@property (nonatomic,assign) CGFloat bottom;
/**相当于left＋width属性*/
@property (nonatomic,assign) CGFloat right;
@end
