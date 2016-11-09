//
//  CountdownView.m
//  testCount
//
//  Created by 付宗建 on 16/11/9.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CountdownView.h"
@interface CountdownView ()
@property (nonatomic,strong) UILabel * countLabel;
@property (nonatomic,assign) int  currentCount;
@property (nonatomic,strong) NSTimer * timer;
@end
@implementation CountdownView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configCountViewUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self configCountViewUI];
    }
    return self;
}
- (void)configCountViewUI{
    [self addSubview:self.countLabel];
}
#pragma mark --- start/stop method
- (void)start{
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
    [self animationMethod];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animationMethod) userInfo:nil repeats:YES];
}
- (void)stop{
    if ([self.delegate respondsToSelector:@selector(CountDownFinish)]) {
        [self.delegate CountDownFinish];
    }
    if (self.timer && [self.timer isValid]) {
        [self.timer invalidate];
    }
    [self removeFromSuperview];
}
- (void)animationMethod{
    [UIView animateWithDuration:0.9 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(2.5, 2.5);
        self.countLabel.transform = transform;
        self.countLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.currentCount == 0) {
                [self stop];
            }else{
                self.countLabel.transform = CGAffineTransformIdentity;
                self.countLabel.alpha = 1.0;
                self.currentCount --;
                if (self.currentCount == 0) {
                    self.countLabel.text = @"Go";
                }else{
                    self.countLabel.text = [NSString stringWithFormat:@"%d",self.currentCount];
                }
            }
        }
    }];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.countLabel.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + 400, self.frame.size.height);
    [self.countLabel setCenter:self.center];
}
#pragma mark --- lazy load
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        float fontSize = self.bounds.size.width * 0.3;
        _countLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.opaque = YES;
        _countLabel.alpha = 1.0;
    }
    return _countLabel;
}
#pragma mark --- setter/getter method
- (int)count{
    if (_count == 0) {
        _count = 5;
    }
    self.currentCount = _count;
    return _count;
}
@end
