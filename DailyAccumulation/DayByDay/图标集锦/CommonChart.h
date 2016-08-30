//
//  CommonChart.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonChart : UIView
/** 图标视图与View的边界值*/
@property (nonatomic,assign) UIEdgeInsets contentInsets;
/** 原点*/
@property (nonatomic,assign) CGPoint  chartOrigin;
/** 绘制线段*/
- (void)drawLineContext:(CGContextRef )context startP:(CGPoint)start endP:(CGPoint)end isDottedLine:(BOOL)isDotted lineColor:(UIColor *)color;
/** 绘制文字*/
- (void)drawText:(NSString *)text context:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color fontSize:(CGFloat)fontSize;
/** 获取文本宽度*/
- (CGFloat)getTextWidthWhenDrawText:(NSString *)text;
/** 动画开始*/
- (void)showAnimation;
/** 清除当前会话*/
- (void)clear;
@end
