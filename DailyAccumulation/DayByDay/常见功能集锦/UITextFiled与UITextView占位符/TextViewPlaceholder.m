//
//  TextViewPlaceholder.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "TextViewPlaceholder.h"
static CGFloat const LableX = 6.0;
static CGFloat const LableY = 7.0;
@interface TextViewPlaceholder ()
@property (nonatomic,strong) UILabel * placeholderLable;
@end
@implementation TextViewPlaceholder
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.font = [UIFont systemFontOfSize:17];
        self.placeholderColor = [UIColor grayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanageNotification) name:UITextViewTextDidChangeNotification object:nil];
        [self addSubview:self.placeholderLable];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLable.frame = CGRectMake(LableX, LableY, self.bounds.size.width - 2 * LableX, 0);
    [self.placeholderLable sizeToFit];
}
- (UILabel *)placeholderLable{
    if (_placeholderLable == nil) {
        _placeholderLable = [[UILabel alloc] init];
        _placeholderLable.numberOfLines = 0;
    }
    return _placeholderLable;
}
#pragma mark --- setter方法实现
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLable.text = placeholder;
    [self setNeedsLayout];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLable.textColor = placeholderColor;
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLable.font = font;
    [self setNeedsLayout];
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self textViewDidChanageNotification];
}
#pragma mark --- 监听方法实现
- (void)textViewDidChanageNotification{
    self.placeholderLable.hidden = self.hasText;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
