//
//  PraiseController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "PraiseController.h"
#import "PraiseButton.h"
@interface PraiseController ()<PraiseDelegate>

@end

@implementation PraiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PraiseButton * praiseButtuon = [[PraiseButton alloc] initWithFrame:CGRectMake(100, 400, 70, 30) normalImage:[UIImage imageNamed:@"ZanFiger0"] selectedImage:[UIImage imageNamed:@"ZanFiger0"] defaultCount:10 defaultSelected:NO];
    praiseButtuon.delegate = self;
    [self.view addSubview:praiseButtuon];
}
- (void)praiseButton:(PraiseButton *)praise didSelected:(BOOL)state{
    NSLog(@"点赞状态%d",state);
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
