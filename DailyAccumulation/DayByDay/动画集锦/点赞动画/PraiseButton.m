//
//  PraiseButton.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "PraiseButton.h"
@interface PraiseImageView ()
@end
@implementation PraiseImageView
- (instancetype)init{
    if (self = [super init]) {
        self.image = [UIImage imageNamed:@"ZanFiger0"];
        UIImage * newImage = [self.image imageWithColor:RandomColor];
        self.image = newImage;
    }
    return self;
}
@end
#define offsetX 30.f
#define offsetY 80.f
@interface PraiseButton ()
@property (nonatomic,strong) UIImage * defaultImage;
@property (nonatomic,strong) UIImage * selectedImage;
@property (nonatomic,assign) NSInteger  defaultCount;
@property (nonatomic,strong) UILabel * countLable;
@property (nonatomic,strong) UIImageView * thumbImageView;
@end
@implementation PraiseButton
- (instancetype)initWithFrame:(CGRect)frame normalImage:(UIImage *)norImage selectedImage:(UIImage *)selImage defaultCount:(NSInteger)defCount{
    if (self = [super initWithFrame:frame]) {
        self.defaultImage = norImage;
        self.selectedImage = selImage;
        self.defaultCount = defCount;
        [self configPraiseButtonUI];
    }
    return self;
}
- (void)configPraiseButtonUI{
    [self addSubview:self.thumbImageView];
    [self addSubview:self.countLable];
    self.layer.cornerRadius = self.height*0.5;
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor colorWithWhite:.9 alpha:.6].CGColor;
    self.backgroundColor = [UIColor colorWithWhite:.1 alpha:.6];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked:)]];
}
- (void)tapGestureClicked:(UITapGestureRecognizer *)gesture{
    
    //动画设置
    CGPoint center = CGPointMake(self.width*0.5, self.height*0.5);
    PraiseImageView * praiseImageView = [[PraiseImageView alloc] init];
    praiseImageView.center = center;
    praiseImageView.alpha = .9f;
    praiseImageView.bounds = CGRectMake(0, 0, 0, 0);
    //向上移动
    NSInteger i = arc4random_uniform(2);
    NSInteger direction = 1 - (2 * i);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    CGPoint endPoint = CGPointMake(center.x, center.y - 200.f);
    
    CGPoint onePoint = CGPointMake(center.x - offsetX * direction, - offsetY);
    CGPoint twoPoint = CGPointMake(center.x + offsetX * direction, - offsetY);
    [path addCurveToPoint:endPoint controlPoint1:onePoint controlPoint2:twoPoint];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 2.f;
    animation.removedOnCompletion = YES;
    [praiseImageView.layer addAnimation:animation forKey:nil];
    
    //先上移一小段距离
    [UIView animateWithDuration:.1f animations:^{
        praiseImageView.transform = CGAffineTransformMakeTranslation(0.f, -20.f);
    }];
    // 弹簧效果弹出
    [UIView animateWithDuration:.2f delay:.1f usingSpringWithDamping:.5f initialSpringVelocity:50.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        praiseImageView.bounds = CGRectMake(0, 0, 25, 25);
    } completion:nil];
    // 渐隐消失
    [UIView animateKeyframesWithDuration:2.f delay:0.f options:0.f animations:^{
        [self addSubview:praiseImageView];
        [UIView addKeyframeWithRelativeStartTime:3 / 4.f relativeDuration:1 / 4.f animations:^{
            praiseImageView.alpha = 0.f;
        }];
    } completion:^(BOOL finished) {
        [praiseImageView removeFromSuperview];
    }];
}
- (UIImageView *)thumbImageView{
    if (_thumbImageView == nil) {
        _thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width * 0.5 - self.height * 0.6) * 0.75, self.height * 0.2, self.height * 0.6, self.height * 0.6)];
        _thumbImageView.image = self.defaultImage;
    }
    return _thumbImageView;
}
- (UILabel *)countLable{
    if (_countLable == nil) {
        _countLable = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.45, 0, self.width * 0.5, self.height)];
        _countLable.text = [NSString stringWithFormat:@"%zd",self.defaultCount];
        _countLable.textAlignment = NSTextAlignmentCenter;
        _countLable.font = [UIFont systemFontOfSize:self.height * 0.6];
        _countLable.textColor = [UIColor whiteColor];
    }
    return _countLable;
}
@end
