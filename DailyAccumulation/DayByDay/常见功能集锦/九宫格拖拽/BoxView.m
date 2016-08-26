//
//  BoxView.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "BoxView.h"
@interface BoxView()
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) UILabel * contentLable;
@end
@implementation BoxView
- (instancetype)initWithFrame:(CGRect)frame contentTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        [self configBoxViewUI];
    }
    return self;
}
- (void)configBoxViewUI{
    _contentLable = [[UILabel alloc] initWithFrame:self.bounds];
    _contentLable.text = self.title;
    _contentLable.userInteractionEnabled = YES;
    _contentLable.font = [UIFont systemFontOfSize:20];
    _contentLable.textColor = [UIColor grayColor];
    _contentLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_contentLable];
    
    //长按手势
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureClicked:)];
    longGesture.minimumPressDuration = 1;
    [self addGestureRecognizer:longGesture];
    
    //点击手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked:)];
    [self addGestureRecognizer:tapGesture];
}
- (void)tapGestureClicked:(UITapGestureRecognizer *)tapGesture{
    if ([self.delegate respondsToSelector:@selector(boxView:didSelectedIndexTag:)]) {
        [self.delegate boxView:self didSelectedIndexTag:self.tag];
    }
}
- (void)longPressGestureClicked:(UILongPressGestureRecognizer *)longGesture{
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:
            _contentLable.textColor = [UIColor redColor];
            self.backgroundColor = [UIColor grayColor];
            if ([self.delegate respondsToSelector:@selector(boxView:beginMoveIndexTag:)]) {
                [self.delegate boxView:self beginMoveIndexTag:self.tag];
            }
            break;
        case UIGestureRecognizerStateChanged:
            if ([self.delegate respondsToSelector:@selector(boxView:longGesture:)]) {
                [self.delegate boxView:self longGesture:longGesture];
            }
            break;
        case UIGestureRecognizerStateEnded:
            _contentLable.textColor = [UIColor grayColor];
            self.backgroundColor = [UIColor whiteColor];
            if ([self.delegate respondsToSelector:@selector(boxView:endMoveIndexTag:)]) {
                [self.delegate boxView:self endMoveIndexTag:self.tag];
            }
            break;
        default:
            break;
    }
}
@end
