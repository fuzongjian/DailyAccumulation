//
//  LineChart.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "CommonChart.h"
typedef NS_ENUM(NSInteger,LineChartType){
    LineChartType_Every = 0,
    LineChartType_Many = 1
};
typedef NS_ENUM(NSInteger,LineChartQuadrantType){
    LineChartQuadrantType_First = 0,
    LineChartQuadrantType_FirstSecond = 1,
    LineChartQuadrantType_FirstFourth = 2,
    LineChartQuadrantType_All = 3
};
@interface LineChart : CommonChart
/** X、Y轴刻度数据  NSNumber、NSString*/
@property (nonatomic,strong) NSArray * xLineDataArray;
@property (nonatomic,strong) NSArray * yLineDataArray;
/** X、Y轴线条宽度、颜色*/
@property (nonatomic,assign) CGFloat  lineWidth;
@property (nonatomic,strong) UIColor * xyLineColor;
/** 点坐标数组，不同类型对应不同的数据源*/
@property (nonatomic,strong) NSArray * valueArray;
/** 折线图类型*/
@property (nonatomic,assign) LineChartType  lineType;
/** 象限类型*/
@property (nonatomic,assign) LineChartQuadrantType  lineQuadrantType;
/** 数值线条颜色*/
@property (nonatomic,strong) NSArray * valueLineColorArray;
/** 点的颜色*/
@property (nonatomic,strong) NSArray * pointColorArray;
/** 刻度值的颜色*/
@property (nonatomic,strong) UIColor * xyNumberColor;
/** 点的引导虚线颜色*/
@property (nonatomic,strong) NSArray * positionLineColorArray;
/** 坐标点数值颜色*/
@property (nonatomic,strong) NSArray * pointNumberColorArray;
/** 是否需要点*/
@property (nonatomic,assign) BOOL  hasPoint;
/** 动画路径线条宽度*/
@property (nonatomic,assign) CGFloat  animationPathWidth;
- (instancetype)initWithFrame:(CGRect)frame lineChartType:(LineChartType)lineChartType;
@end
