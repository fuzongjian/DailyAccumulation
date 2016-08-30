//
//  RunningLineController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "RunningLineController.h"
#import "LineChart.h"
@interface RunningLineController ()

@end

@implementation RunningLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testOne];
    [self testTwo];
}
- (void)testTwo{
      LineChart * lineChart = [[LineChart alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 300) lineChartType:LineChartType_Many];
    lineChart.xLineDataArray = @[@[@"-3",@"-2",@"-1"],@[@0,@1,@2,@3]];
    lineChart.lineQuadrantType = LineChartQuadrantType_FirstSecond;
    lineChart.valueArray = @[@[@"5",@"2",@"7",@4,@25,@15,@6],@[@"1",@"2",@"1",@6,@4,@9,@7]];
    /* 值折线的折线颜色 默认暗黑色*/
    lineChart.valueLineColorArray =@[ [UIColor purpleColor], [UIColor brownColor]];
    
    /* 值点的颜色 默认橘黄色*/
    lineChart.pointColorArray = @[[UIColor orangeColor],[UIColor yellowColor]];
    
    /* X和Y轴的颜色 默认暗黑色 */
    lineChart.xyLineColor = [UIColor redColor];
    
    /* XY轴的刻度颜色 m */
    lineChart.xyNumberColor = [UIColor blueColor];
    
    [self.view addSubview:lineChart];
    
    [lineChart showAnimation];
}
- (void)testOne{
    LineChart * lineChart = [[LineChart alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 300) lineChartType:LineChartType_Many];
    /* X轴的刻度值 可以传入NSString或NSNumber类型  并且数据结构随折线图类型变化而变化 详情看文档或其他象限X轴数据源示例*/
    lineChart.xLineDataArray = @[@"0",@"1",@"2",@3,@4,@5,@6,@7];
    
    /* 折线图的不同类型  按照象限划分 不同象限对应不同X轴刻度数据源和不同的值数据源 */
    lineChart.lineQuadrantType = LineChartQuadrantType_First;
    
    /* 数据源 */
    lineChart.valueArray = @[@[@"1",@"2",@"1",@6,@4,@9,@6,@7]];
    
    /* 值折线的折线颜色 默认暗黑色*/
    lineChart.valueLineColorArray =@[ [UIColor purpleColor], [UIColor brownColor]];
    
    /* 值点的颜色 默认橘黄色*/
    lineChart.pointColorArray = @[[UIColor orangeColor],[UIColor yellowColor]];
    
    /* X和Y轴的颜色 默认暗黑色 */
    lineChart.xyLineColor = [UIColor redColor];
    
    /* XY轴的刻度颜色 m */
    lineChart.xyNumberColor = [UIColor blackColor];
    
    /* 坐标点的虚线颜色 */
    lineChart.positionLineColorArray = @[[UIColor blueColor],[UIColor greenColor]];
    
    [self.view addSubview:lineChart];
    [lineChart showAnimation];
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
