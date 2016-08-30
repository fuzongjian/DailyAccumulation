//
//  CommonChart.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CommonChart.h"

@implementation CommonChart
- (void)clear{}
- (void)showAnimation{}
/**
 *  @brief 绘制线段
 *
 *  @param context  图形绘制的上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否虚线
 *  @param color    线段颜色
 */
- (void)drawLineContext:(CGContextRef )context startP:(CGPoint)start endP:(CGPoint)end isDottedLine:(BOOL)isDotted lineColor:(UIColor *)color{
    //移动到点
    CGContextMoveToPoint(context, start.x, start.y);
    //连接
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextSetLineWidth(context, 0.5);
    [color setStroke];
    if (isDotted) {
        CGFloat ss[] = {0.5,2};
        CGContextSetLineDash(context, 0, ss, 2);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
}
/**
 *  @brief 绘制文字
 *
 *  @param text     文字neirong
 *  @param context  图形绘制上下文
 *  @param point    绘制点
 *  @param color    绘制颜色
 *  @param fontSize 字体大小
 */
- (void)drawText:(NSString *)text context:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color fontSize:(CGFloat)fontSize{
    [[NSString stringWithFormat:@"%@",text] drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
}
/**
 *  @brief 获取文本宽度
 *
 *  @param text 文本内容
 *
 *  @return 文本宽度
 */
- (CGFloat)getTextWidthWhenDrawText:(NSString *)text{
    CGSize size = [[NSString stringWithFormat:@"%@",text] boundingRectWithSize:CGSizeMake(100, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:7]} context:nil].size;
    return size.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
