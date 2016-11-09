//
//  BageValueButton.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/9/20.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "BageValueButton.h"
@interface BageValueButton ()
@property (nonatomic,strong) UIView * smallCircle;
@property (nonatomic,strong) CAShapeLayer * shap;
@end
@implementation BageValueButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self configBageValueButtonUI];
        NSLog(@"hello");
    }
    return self;
}
- (void)configBageValueButtonUI{
    
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setBackgroundColor:[UIColor redColor]];
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];
    
    
    [self.superview insertSubview:self.smallCircle belowSubview:self];
}
- (void)panGesture:(UIPanGestureRecognizer *)pan{
    // 当前移动的偏移量
    CGPoint tranP = [pan translationInView:self];
    CGPoint center = self.center;
    center.x += tranP.x;
    center.y += tranP.y;
    self.center = center;
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle bigCircle:self];
    //取出小圆半径
    CGFloat radius = self.bounds.size.width * 0.5;
    radius -= distance * 0.1;
    //重新设置小圆的宽高
    self.smallCircle.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    self.smallCircle.layer.cornerRadius = radius;
    
    if (self.smallCircle.hidden == NO) {
        //返回一个不规则的路径
        UIBezierPath * path = [self pathWithSmallCircle:self.smallCircle bigCircle:self];
        // 把路径转换成图形
        self.shap.path = path.CGPath;
    }
    if (distance > 60) {
        self.smallCircle.hidden = YES;
        [self.shap removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (distance < 60) {
            [self.shap removeFromSuperlayer];
            self.center = self.smallCircle.center;
            self.smallCircle.hidden = NO;
        }else{
            [self removeFromSuperview];
            NSLog(@"finish");
        }
    }
    
}
/**
 *  @brief 计算两个圆之间的距离
 *
 *  @return 距离
 */
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bigCircle{
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    return  sqrtf(offsetX * offsetX + offsetY * offsetY);
}
/**
 *  @brief 根据连个圆来描述一个不规则路径
 *
 *  @return 路径
 */
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bgCircle{
    CGFloat x1 = smallCircle.center.x;
    CGFloat x2 = bgCircle.center.x;
    
    CGFloat y1 = smallCircle.center.y;
    CGFloat y2 = bgCircle.center.y;
    
    CGFloat distance = [self distanceWithSmallCircle:smallCircle bigCircle:bgCircle];
    
    CGFloat cosΘ = (y2 - y1) / distance;
    CGFloat sinΘ = (x2 - x1) / distance;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bgCircle.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosΘ, y1 + r1 * sinΘ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosΘ, y1 - r1 * sinΘ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosΘ, y2 - r2 * sinΘ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosΘ, y2 + r2 * sinΘ);
    CGPoint pointO = CGPointMake(pointA.x + distance * 0.5 * sinΘ, pointA.y + distance * 0.5 * cosΘ);
    CGPoint pointP = CGPointMake(pointB.x + distance * 0.5 * sinΘ, pointB.y + distance * 0.5 * cosΘ);
    
    //描述路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    // AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    // BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}
- (UIView *)smallCircle{
    if (_smallCircle == nil) {
        _smallCircle = [[UIView alloc] initWithFrame:self.bounds];
        _smallCircle.center  = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
        _smallCircle.layer.cornerRadius = self.layer.cornerRadius;
        _smallCircle.backgroundColor = self.backgroundColor;
    }
    return _smallCircle;
}
- (CAShapeLayer *)shap{
    if (_shap == nil) {
        _shap = [CAShapeLayer layer];
        _shap.fillColor = [UIColor redColor].CGColor;
        [self.superview.layer insertSublayer:_shap atIndex:0];
    }
    return _shap;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
