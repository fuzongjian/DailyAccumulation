//
//  RootViewController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/16.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * controllersArray;
@property (nonatomic,strong) NSArray * titleArray;
@end
@implementation RootViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.titleArray = [NSArray arrayWithObjects:@"pop_Present动画",@"微信支付密码输入", nil];
    self.controllersArray = [NSArray arrayWithObjects:@"PopPresentController", @"PasswordController",nil];
    [self.view addSubview:self.tableView];
    
}
#pragma mark --- UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.controllersArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * nextController = [[NSClassFromString([self.controllersArray objectAtIndex:indexPath.row]) alloc] init];
    nextController.title = [self.titleArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextController animated:YES];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end