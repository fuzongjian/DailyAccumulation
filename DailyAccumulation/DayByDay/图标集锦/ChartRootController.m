//
//  ChartRootController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "ChartRootController.h"
@interface ChartRootController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * dataArray;
@end
@implementation ChartRootController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configChartRootControllerUI];
}
- (void)configChartRootControllerUI{
    [self.view addSubview:self.tableView];
}
#pragma mark --- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * controllerStr = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    UIViewController * nextController = [[NSClassFromString(controllerStr) alloc] init];
    nextController.title = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];;
    [self.navigationController pushViewController:nextController animated:YES];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chart" ofType:@"plist"]];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
