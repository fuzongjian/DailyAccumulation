//
//  TextViewFiledController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "TextViewFiledController.h"
#import "TextViewPlaceholder.h"
@interface TextViewFiledController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) TextViewPlaceholder * textView;
@end

@implementation TextViewFiledController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textView];
    // Do any additional setup after loading the view.
}
/**
 *  @使用系统键盘的时候，输入汉字有时检查不出来
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"1%@",string);
    return YES;
}
- (void)textEditingChanged{
    NSLog(@"2%@",self.textField.text);
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 40)];
        _textField.borderStyle = UITextBorderStyleBezel;
        _textField.placeholder = @"求知若渴，虚怀若谷。";
        /**
         *  @brief 利用KVC设置Placeholder的字体颜色、大小
         */
        [_textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
        
        _textField.delegate = self;
        /**
         *  @brief 用下面这种方法来检测汉字变化，方法会调用
         */
        [_textField addTarget:self action:@selector(textEditingChanged) forControlEvents:UIControlEventEditingChanged];

    }
    return _textField;
}
- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[TextViewPlaceholder alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 100)];
        _textView.placeholder = @"非淡泊无以明志，非宁静无以致远。非淡泊无以明志，非宁静无以致远。非淡泊无以明志，非宁静无以致远。非淡泊无以明志，非宁静无以致远。";
    }
    return _textView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
