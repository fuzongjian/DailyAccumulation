//
//  WeiboPopController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "WeiboPopController.h"
#import "CustomMenuController.h"
@interface WeiboPopController ()<CustomMenuDelegate>
@property (nonatomic,strong) UIButton * popButton;
@end

@implementation WeiboPopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [self.view addSubview:self.popButton];
    
    // Do any additional setup after loading the view.
}
- (void)popButtonClicked:(UIButton *)sender{
    MenuItem * addMatter = [[MenuItem alloc] init];
    addMatter.title = @"添加事项";
    addMatter.icon = [UIImage imageNamed:@"addMatters"];
    
    MenuItem * addschedule = [[MenuItem alloc] init];
    addschedule.title = @"添加日程";
    addschedule.icon = [UIImage imageNamed:@"addSchedule"];
    
    MenuItem * addChat = [[MenuItem alloc] init];
    addChat.title = @"发起会话";
    addChat.icon = [UIImage imageNamed:@"setupChat"];
    
    MenuItem * addContact = [[MenuItem alloc] init];
    addContact.title = @"查找联系人";
    addContact.icon = [UIImage imageNamed:@"searchContacts"];
    
    CustomMenuController * customMenu = [[CustomMenuController alloc] initWithMenuItems:@[addMatter,addschedule,addChat,addContact]];
    customMenu.delegate = self;
    customMenu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    customMenu.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:customMenu animated:YES completion:nil];
}
- (void)customMenuDidTapClickBackground{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)customMenuDidTapOnItem:(MenuItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIButton *)popButton{
    if (_popButton == nil) {
        _popButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_popButton setTitle:@"弹出" forState:UIControlStateNormal];
        _popButton.frame = CGRectMake(0, 0, 100, 100);
        _popButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _popButton.center = self.view.center;
        _popButton.layer.borderWidth = 1;
        _popButton.layer.borderColor = [UIColor redColor].CGColor;
        [_popButton addTarget:self action:@selector(popButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popButton;
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
