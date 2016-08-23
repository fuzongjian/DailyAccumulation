//
//  CustomFontController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/22.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CustomFontController.h"

@interface CustomFontController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSArray * fontNames;
@property (nonatomic,strong) NSArray * fontStr;
@property (nonatomic,strong) UILabel * fontLable;
@end

@implementation CustomFontController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 步骤
    // 1、下载字体，拖入项目文件夹，然后采用Add Files to "项目名称"加入进来
    // 2、配置info.plist，添加 Fonts provided by application，然后将字体型号以及后缀名填入
    // 3、注意文字名字，show in finder然后双击字体文件查看字体名字
    // 4、集成即可
    
    
    self.fontNames = [NSArray arrayWithObjects:@"Yuppy SC",@"Chalkduster", @"Wawati TC",nil];
    
    UIButton * chooseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    chooseButton.frame = CGRectMake(0, 100, SCREEN_WIDTH, 40);
    [chooseButton setTitle:@"点击选择字体" forState:UIControlStateNormal];
    chooseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseButton];
    
    
    _fontLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 40)];
    _fontLable.textAlignment = NSTextAlignmentCenter;
    _fontLable.font = [UIFont systemFontOfSize:25];
//    _fontLable.font = [UIFont fontWithName:@"Chalkduster" size:25];
    _fontLable.text = @"求知若渴，虚怀若谷。";
    [self.view addSubview:_fontLable];
    
    // Do any additional setup after loading the view.
}
- (void)chooseButtonClicked:(UIButton *)sender{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"选择字体" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"雅痞-简",@"无名",@"娃娃体-繁", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) return;
    
    _fontLable.font = [UIFont fontWithName:[self.fontNames objectAtIndex:buttonIndex -1] size:25];
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
