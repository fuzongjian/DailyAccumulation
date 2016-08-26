//
//  PasswordView.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "PasswordView.h"
#define NUMBER_COUNT 6//密码位数
#define DOT_WIDTH 10//黑点的大小
#define INPUTVIEW_HEIGHT 40//输入框的高度
#define INPUTVIEW_MARGIN 40//左右两边的距离
@interface PasswordView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField * inputTextField;
@property (nonatomic,strong) UIView * inputView;
@property (nonatomic,strong) NSMutableArray * lableArray;
@end
static PasswordView * passwordView;
@implementation PasswordView
+ (void)showOnView:(UIView *)view completion:(completionBlock)completion{
    passwordView = [[PasswordView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) completion:completion];
    passwordView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
    [view addSubview:passwordView];
    
}
- (instancetype)initWithFrame:(CGRect)frame completion:(completionBlock)completion{
    if (self = [super initWithFrame:frame]) {
        [self configPasswordViewUI];
        self.completion = completion;
    }
    return self;
}
- (void)configPasswordViewUI{
    [self addSubview:self.inputView];
}
#pragma mark --- UITextFiled delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /**
     *  @brief 控制输入字符的个数
     */
    if (textField.text.length > NUMBER_COUNT && string.length) {
        return NO;
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    /**
     *  @brief 正则匹配
     */
    if (![predicate evaluateWithObject:string]) return NO;
    /**
     *  @brief 输入的密码
     */
    NSString * password ;
    if (string.length <= 0) {
        password = [textField.text substringToIndex:textField.text.length - 1];
    }else{
        password = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    void(^resetDisplay)(NSInteger) = ^(NSInteger count){
        for (UILabel * dotLable in self.lableArray) {
            dotLable.hidden = YES;
        }
        for (int i = 0; i < count; i ++) {
            ((UILabel *)[self.lableArray objectAtIndex:i]).hidden = NO;
        }
    };
    resetDisplay(password.length);
    if (password.length == 6) {
        if (self.completion) {
            self.completion(password);
        }
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:.3f];
    }
    return YES;
}
- (UIView *)inputView{
    if (_inputView == nil) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(INPUTVIEW_MARGIN, INPUTVIEW_MARGIN * 2, SCREEN_WIDTH - INPUTVIEW_MARGIN * 2, INPUTVIEW_HEIGHT)];
        _inputView.layer.cornerRadius = 5.f;
        _inputView.layer.masksToBounds = YES;
        _inputView.backgroundColor = [UIColor colorWithWhite:1. alpha:.95];
        
        //输入
        [_inputView addSubview:self.inputTextField];
        CGFloat width = _inputView.bounds.size.width / NUMBER_COUNT;
        for (int i = 0; i < NUMBER_COUNT; i ++) {
            UILabel * dotLable = [[UILabel alloc] initWithFrame:CGRectMake((width - DOT_WIDTH)/2.f + i * width, (_inputView.bounds.size.height - DOT_WIDTH)/2.f, DOT_WIDTH, DOT_WIDTH)];
            dotLable.backgroundColor = [UIColor blackColor];
            dotLable.layer.cornerRadius = DOT_WIDTH / 2.f;
            dotLable.clipsToBounds = YES;
            dotLable.hidden = YES;
            [self.lableArray addObject:dotLable];
            [_inputView addSubview:dotLable];
            
            
            if (i == NUMBER_COUNT -1) continue;
            UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * width, 0, .5f, _inputView.bounds.size.height)];
            line.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.];
            [_inputView addSubview:line];
        }
        
    }
    return _inputView;
}
- (void)dismiss{
    [self.inputView resignFirstResponder];
    [UIView animateWithDuration:0.5f animations:^{
        passwordView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        passwordView.alpha = 0;
    } completion:^(BOOL finished) {
        [passwordView removeFromSuperview];
    }];
}
- (UITextField *)inputTextField{
    if (_inputTextField == nil) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.delegate = self;
        _inputTextField.hidden = YES;
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_inputTextField becomeFirstResponder];
    }
    return _inputTextField;
}
- (NSMutableArray *)lableArray{
    if (_lableArray == nil) {
        _lableArray = [NSMutableArray array];
    }
    return _lableArray;
}
@end
