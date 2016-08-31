//
//  LineChart.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/30.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "LineChart.h"
#define kMarginSuperView 20.0
@interface LineChart()
/** X、Y轴的宽度*/
@property (nonatomic,assign) CGFloat  xLength;
@property (nonatomic,assign) CGFloat  yLength;
/** X、Y轴的刻度*/
@property (nonatomic,assign) CGFloat  perXLen;
@property (nonatomic,assign) CGFloat  perYLen;
@property (nonatomic,assign) CGFloat  perValue;
@property (nonatomic,strong) NSMutableArray * drawDataArray;
@property (nonatomic,strong) CAShapeLayer * shapeLayer;
@property (nonatomic,assign) BOOL  isEndAnimation;
@property (nonatomic,strong) NSMutableArray * layerArray;
@end
@implementation LineChart
- (instancetype)initWithFrame:(CGRect)frame lineChartType:(LineChartType)lineChartType{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.7 blue:0.2 alpha:0.3];
        _lineType = lineChartType;
        _lineWidth = 0.5;
        self.contentInsets = UIEdgeInsetsMake(10, 20, 10, 10);
        _yLineDataArray  = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _xLineDataArray  = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _xyLineColor = [UIColor darkGrayColor];
        _pointNumberColorArray = @[[UIColor redColor]];
        _positionLineColorArray = @[[UIColor darkGrayColor]];
        _pointColorArray = @[[UIColor orangeColor]];
        _xyNumberColor = [UIColor darkGrayColor];
        _valueLineColorArray = @[[UIColor redColor]];
        _layerArray = [NSMutableArray array];
        [self configChartXAndYLength];
        [self configChartOrigin];
        [self configPerXAndPery];
    }
    return self;
}
#pragma mark --- config method
/**
 *  @brief 获取X与Y轴的长度
 */
- (void)configChartXAndYLength{
    _xLength = CGRectGetWidth(self.frame) - self.contentInsets.left - self.contentInsets.right;
    _yLength = CGRectGetHeight(self.frame) - self.contentInsets.top - self.contentInsets.bottom;
}
/**
 *  @brief 构建折线图原点
 */
- (void)configChartOrigin{
    switch (self.lineQuadrantType) {
        case LineChartQuadrantType_First:
            self.chartOrigin = P_M(self.contentInsets.left, self.height - self.contentInsets.bottom);
            break;
        case LineChartQuadrantType_FirstSecond:
            self.chartOrigin = P_M(self.contentInsets.left + _xLength / 2.0, CGRectGetHeight(self.frame) - self.contentInsets.bottom);
            break;
        case LineChartQuadrantType_FirstFourth:
            self.chartOrigin = P_M(self.contentInsets.left, self.contentInsets.top + _yLength / 2.0 );
            break;
        case LineChartQuadrantType_All:
            self.chartOrigin = P_M(self.contentInsets.left + _xLength / 2.0, self.contentInsets.top + _yLength / 2.0);
            break;
        default:
            break;
    }
}
/**
 *  @brief 获取X、Y轴刻度间距
 */
- (void)configPerXAndPery{
    switch (self.lineQuadrantType) {
        case LineChartQuadrantType_First:
            _perXLen = (_xLength - kMarginSuperView) / (_xLineDataArray.count -1);
            _perYLen = (_yLength - kMarginSuperView) / _yLineDataArray.count;
            break;
        case LineChartQuadrantType_FirstSecond:
            _perXLen = (_xLength / 2.0 - kMarginSuperView) / [_xLineDataArray[0] count];
            _perYLen = (_yLength - kMarginSuperView) / _yLineDataArray.count;
            break;
        case LineChartQuadrantType_FirstFourth:
            _perXLen = (_xLength - kMarginSuperView) / (_xLineDataArray.count -1);
            _perYLen = (_yLength / 2.0 - kMarginSuperView) / [_yLineDataArray[0] count];
            break;
        case LineChartQuadrantType_All:
            _perXLen = (_xLength / 2.0 - kMarginSuperView) / [_xLineDataArray[0] count];
            _perYLen = (_yLength / 2.0 - kMarginSuperView) / [_yLineDataArray[0] count];
            break;
        default:
            break;
    }
}
/**
 *  @brief 转换值数组为点数组
 */
- (void)configValueDataArray{
    _drawDataArray = [NSMutableArray array];
    if (_valueArray.count == 0) return;
    switch (_lineQuadrantType) {
        case LineChartQuadrantType_First:
            _perValue = _perYLen / [[_yLineDataArray firstObject] floatValue];
            for (NSArray * valueArr in _valueArray) {
                NSMutableArray * dataArr = [NSMutableArray array];
                for (NSInteger i = 0; i < valueArr.count; i ++) {
                    CGPoint point = P_M(i * _perXLen + self.chartOrigin.x, self.contentInsets.top + _yLength - [valueArr[i] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                [_drawDataArray addObject:[dataArr copy]];
            }
            break;
        case LineChartQuadrantType_FirstSecond:
            
            _perValue = _perYLen / [[_yLineDataArray firstObject] floatValue];
            
            for (NSArray * valueArr in _valueArray) {
                NSMutableArray * dataArr = [NSMutableArray array];
                
                CGPoint point;
                for (NSInteger i = 0; i < [_xLineDataArray[0] count]; i ++) {
                    point = P_M(self.contentInsets.left + kMarginSuperView + i * _perXLen, self.contentInsets.top + _yLength - [valueArr[i] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                for (NSInteger i = 0; i < [_xLineDataArray[1] count]; i ++) {
                    point = P_M(self.chartOrigin.x + i * _perXLen, self.contentInsets.top + _yLength - [valueArr[i + [_xLineDataArray[0] count]] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                [_drawDataArray addObject:[dataArr copy]];
            }
            break;
        case LineChartQuadrantType_FirstFourth:
            _perValue = _perYLen / [[_yLineDataArray[0] firstObject] floatValue];
            for (NSArray * valueArr in _valueArray) {
                NSMutableArray * dataArr = [NSMutableArray array];
                for (NSInteger i = 0; i < valueArr.count; i ++) {
                    CGPoint point = P_M(i * _perXLen + self.chartOrigin.x, self.chartOrigin.y - [valueArr[i] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                [_drawDataArray addObject:[dataArr copy]];
            }
            break;
        case LineChartQuadrantType_All:
            _perValue = _perYLen / [[_yLineDataArray[0] firstObject] floatValue];
            for (NSArray * valueArr in _valueArray) {
                NSMutableArray * dataArr = [NSMutableArray array];
                CGPoint point;
                for (NSInteger i = 0; i < [_xLineDataArray[0] count]; i ++) {
                    point = P_M(self.contentInsets.left + kMarginSuperView + i * _perXLen, self.chartOrigin.y - [valueArr[i] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                for (NSInteger i = 0 ; i < [_xLineDataArray[1] count]; i ++) {
                    point = P_M(self.chartOrigin.x + i * _perXLen, self.chartOrigin.y - [valueArr[i + [_xLineDataArray[0] count]] floatValue] * _perValue);
                    [dataArr addObject:[NSValue valueWithCGPoint:point]];
                }
                [_drawDataArray addObject:[dataArr copy]];
            }
            break;
        default:
            break;
    }
}
#pragma mark --- setter method
- (void)setLineQuadrantType:(LineChartQuadrantType)lineQuadrantType{
    _lineQuadrantType = lineQuadrantType;
    [self configChartOrigin];
}
- (void)setValueArray:(NSArray *)valueArray{
    _valueArray = valueArray;
    [self updateYScale];
}
/** 更新Y轴的刻度大小*/
- (void)updateYScale{
    switch (_lineQuadrantType) {
        case LineChartQuadrantType_FirstFourth:{
            
            NSInteger max = 0;
            NSInteger min = 0;
            
            for (NSArray * array in _valueArray) {
                for (NSString * number in array) {
                    NSInteger i = [number integerValue];
                    if (i >= max) {
                        max = i;
                    }
                    if (i <= min) {
                        min = i;
                    }
                }
            }
            
            
            
            min = labs(min);
            max = (min < max ? (max) : (min));
            if (max % 5 == 0) {
                max = max;
            }else{
                max = (max / 5 + 1) * 5;
            }
            
            NSMutableArray * arr = [NSMutableArray array];
            NSMutableArray * minArr = [NSMutableArray array];
            if (max <= 5) {
                for (NSInteger i = 0; i < 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i+1)*1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i+1)*1]];
                }
            }
            if (max <= 10 && max > 5) {
                for (NSInteger i = 0; i < 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i+1)*2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i+1)*2]];
                }
            }else if (max > 10){
                for (NSInteger i = 0; i < max / 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i+1)*5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i+1)*5]];
                }
            }
            _yLineDataArray = @[[arr copy],[minArr copy]];
            [self setNeedsDisplay];
        }
            
            break;
        case LineChartQuadrantType_All:{
            
            NSInteger max = 0;
            NSInteger min = 0;
            
            for (NSArray * arr in _valueArray) {
                for (NSString * number in arr) {
                    NSInteger i = [number integerValue];
                    if (i >= max) {
                        max = i;
                    }
                    if (i <= min) {
                        min = i;
                    }
                }
            }
            
            min = labs(min);
            max = (min < max?(max):(min));
            if (max%5 == 0) {
                max = max;
            }else{
                max = (max / 5 + 1) * 5;
            }
            NSMutableArray * arr = [NSMutableArray array];
            NSMutableArray * minArr = [NSMutableArray array];
            if (max <= 5) {
                for (NSInteger i = 0; i < 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i + 1) * 1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i + 1) *1]];
                }
            }
            if (max <= 10 && max > 5) {
                for (NSInteger i = 0; i < 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i + 1) * 2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i + 1) * 2]];
                }
            }else if (max > 10){
                for (NSInteger i = 0; i < max / 5; i ++) {
                    [arr addObject:[NSString stringWithFormat:@"%zd",(i + 1) * 5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%zd",(i + 1) * 5]];
                }
            }
            _yLineDataArray = @[[arr copy],[minArr copy]];
            [self setNeedsDisplay];
        }
            break;
        default:{
            if (_valueArray.count) {
                
                NSInteger max = 0;
                
                for (NSArray * arr in _valueArray) {
                    for (NSString * number in arr) {
                        NSInteger i = [number integerValue];
                        if (i >= max) {
                            max = i;
                        }
                    }
                }
                
                if (max % 5 == 0) {
                    max = max;
                }else{
                    max = (max / 5 + 1) * 5;
                }
                _yLineDataArray = nil;
                NSMutableArray * arr = [NSMutableArray array];
                if (max <= 5) {
                    for (NSInteger i = 0; i < 5; i ++) {
                        [arr addObject:[NSString  stringWithFormat:@"%zd",(i + 1) * 1]];
                    }
                }
                if (max <= 10 && max > 5) {
                    for (NSInteger i = 0; i < 5; i ++) {
                        [arr addObject:[NSString stringWithFormat:@"%zd",(i + 1)*2]];
                    }
                }else if (max > 10){
                    for (NSInteger i = 0; i < max / 5; i ++) {
                        [arr addObject:[NSString stringWithFormat:@"%zd",(i + 1) * 5]];
                    }
                }
                _yLineDataArray = [arr copy];
                [self setNeedsDisplay];
            }
        }
            break;
    }
}

#pragma mark --- system method
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawXAndYLineWithContext:context];
    if (!_isEndAnimation)return;
    if (_drawDataArray.count) {
        [self drawPositonLineWithContext:context];
    }
}
/** 绘制x与y轴*/
- (void)drawXAndYLineWithContext:(CGContextRef)context{
    switch (_lineQuadrantType) {
        case LineChartQuadrantType_First:
            [self drawLineContext:context startP:self.chartOrigin endP:P_M(self.contentInsets.left + _xLength, self.chartOrigin.y) isDottedLine:NO lineColor:_xyLineColor];
            [self drawLineContext:context startP:self.chartOrigin endP:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength) isDottedLine:NO lineColor:_xyLineColor];
            if (_xLineDataArray.count > 0) {
                CGFloat xPace = (_xLength - kMarginSuperView) / (_xLineDataArray.count -1);
                
                for (NSInteger i = 0; i < _xLineDataArray.count; i ++) {
                    CGPoint point = P_M(i * xPace + self.chartOrigin.x, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:_xLineDataArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y - 3) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArray[i]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
            }
            if (_yLineDataArray.count > 0) {
                CGFloat yPace = (_yLength - kMarginSuperView) / (_yLineDataArray.count);
                for (NSInteger i = 0; i < _yLineDataArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y - (i + 1) * yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:_yLineDataArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArray[i]] context:context point:P_M(point.x - len - 3,point.y - 3 ) color:_xyNumberColor fontSize:7.0];
                }
            }
            break;
        case LineChartQuadrantType_FirstSecond:{
            [self drawLineContext:context startP:P_M(self.contentInsets.left, self.chartOrigin.y) endP:P_M(self.contentInsets.left + _xLength, self.chartOrigin.y) isDottedLine:NO lineColor:_xyLineColor];
            [self drawLineContext:context startP:self.chartOrigin endP:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength) isDottedLine:NO lineColor:_xyLineColor];
            if (_xLineDataArray.count == 2) {
                NSArray * rightArray = _xLineDataArray[1];
                NSArray * leftArray = _xLineDataArray[0];
                
                CGFloat xPace = (_xLength / 2 - kMarginSuperView) / (rightArray.count - 1);
                
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    CGPoint point = P_M(i * xPace + self.chartOrigin.x, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:rightArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y -3) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",rightArray[i]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x - (i + 1) * xPace, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:leftArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y - 3) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",leftArray[leftArray.count - i - 1]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
            }
            if (_yLineDataArray.count > 0) {
                CGFloat yPace = (_yLength - kMarginSuperView) / (_yLineDataArray.count);
                for (NSInteger i = 0; i < _yLineDataArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y - (i + 1) * yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:_yLineDataArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArray[i]] context:context point:P_M(point.x - len - 3, point.y - 3) color:_xyNumberColor fontSize:7.0];
                }
            }
        }
            break;
        case LineChartQuadrantType_FirstFourth:{
            [self drawLineContext:context startP:self.chartOrigin endP:P_M(self.contentInsets.left + _xLength, self.chartOrigin.y) isDottedLine:NO lineColor:_xyLineColor];
            [self drawLineContext:context startP:P_M(self.contentInsets.left, CGRectGetHeight(self.frame) - self.contentInsets.bottom) endP:P_M(self.chartOrigin.x, self.contentInsets.top) isDottedLine:NO lineColor:_xyLineColor];
            
            if (_xLineDataArray.count > 0) {
                CGFloat xPace = (_xLength - kMarginSuperView) / (_xLineDataArray.count - 1);
                for (NSInteger i = 0; i < _xLineDataArray.count; i ++) {
                    CGPoint point = P_M(i * xPace + self.chartOrigin.x, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:_xLineDataArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y - 3) isDottedLine:NO lineColor:_xyLineColor];
                    if (i == 0) {
                        len = -2;
                    }
                    [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArray[i]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
            }
            if (_yLineDataArray.count == 2) {
                NSArray * topArray = _yLineDataArray[0];
                NSArray * bottomArray = _yLineDataArray[1];
                CGFloat yPace = (_yLength / 2 - kMarginSuperView) / ([_yLineDataArray[0] count]);
                _perYLen = yPace;
                for (NSInteger i = 0; i < topArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y - (i + 1) * yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:topArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",topArray[i]] context:context point:P_M(point.x - len - 3, point.y - 3) color:_xyNumberColor fontSize:7.0];
                }
                for (NSInteger i = 0; i < bottomArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y + (i +1) * yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:bottomArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",bottomArray[i]] context:context point:P_M(point.x - len - 3, point.y - 3) color:_xyNumberColor fontSize:7.0];
                }
            }
            
        }
            break;
        case LineChartQuadrantType_All:{
            [self drawLineContext:context startP:P_M(self.chartOrigin.x - _xLength / 2, self.chartOrigin.y) endP:P_M(self.chartOrigin.x + _xLength / 2, self.chartOrigin.y) isDottedLine:NO lineColor:_xyLineColor];
            [self drawLineContext:context startP:P_M(self.chartOrigin.x, self.chartOrigin.y + _yLength / 2) endP:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength / 2) isDottedLine:NO lineColor:_xyLineColor];
            
            if (_xLineDataArray.count == 2) {
                NSArray * rightArray = _xLineDataArray[1];
                NSArray * leftArray = _xLineDataArray[0];
                
                CGFloat xPace = (_xLength / 2 - kMarginSuperView) / (rightArray.count - 1);
                
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    CGPoint point = P_M(i * xPace + self.chartOrigin.x, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:rightArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y - 3) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",rightArray[i]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x - (i + 1) * xPace, self.chartOrigin.y);
                    CGFloat len = [self getTextWidthWhenDrawText:leftArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x, point.y - 3) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",leftArray[leftArray.count - i - 1]] context:context point:P_M(point.x - len / 2, point.y + 2) color:_xyNumberColor fontSize:7.0];
                }
            }
            
            if (_yLineDataArray.count == 2) {
                NSArray * topArray = _yLineDataArray[0];
                NSArray * bottomArray = _yLineDataArray[1];
                CGFloat yPace = (_yLength / 2 - kMarginSuperView) / ([_yLineDataArray[0] count]);
                _perYLen = yPace;
                for (NSInteger i = 0; i < topArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y - (i + 1)*yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:topArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",topArray[i]] context:context point:P_M(point.x - len - 3, point.y - 3) color:_xyNumberColor fontSize:7.0];
                }
                for (NSInteger i = 0; i < bottomArray.count; i ++) {
                    CGPoint point = P_M(self.chartOrigin.x, self.chartOrigin.y + (i + 1) * yPace);
                    CGFloat len = [self getTextWidthWhenDrawText:bottomArray[i]];
                    [self drawLineContext:context startP:point endP:P_M(point.x + 3, point.y) isDottedLine:NO lineColor:_xyLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",bottomArray[i]] context:context point:P_M(point.x - len - 3, point.y - 3) color:_xyNumberColor fontSize:7.0];
                }
            }
        }
            break;
        default:
            break;
    }
}
/**
 *  @brief 设置点的引导虚线
 *
 *  @param context 图形上下文
 */
- (void)drawPositonLineWithContext:(CGContextRef)context{
    if (_drawDataArray.count == 0) return;
    
    for (NSInteger i =0; i < _valueArray.count; i ++) {
        
        NSArray * arr = _drawDataArray[i];
        
        for (NSInteger j = 0; j < arr.count; j ++) {
            
            CGPoint point = [arr[j] CGPointValue];
            UIColor * positionLineColor;
            if (_positionLineColorArray.count == _valueArray.count) {
                positionLineColor = _positionLineColorArray[i];
            }else{
                positionLineColor = [UIColor orangeColor];
            }
            
            [self drawLineContext:context startP:P_M(self.chartOrigin.x, point.y) endP:point isDottedLine:YES lineColor:positionLineColor];
            [self drawLineContext:context startP:P_M(point.x, self.chartOrigin.y) endP:point isDottedLine:YES lineColor:positionLineColor];
            
            if (point.y != 0) {
                UIColor * pointNumberColor = (_pointNumberColorArray.count == _valueArray.count ? (_pointNumberColorArray[i]) : ([UIColor orangeColor]));
                switch (_lineQuadrantType) {
                    case LineChartQuadrantType_First:{
                        [self drawText:[NSString stringWithFormat:@"(%@,%@)",_xLineDataArray[j],_valueArray[i][j]] context:context point:point color:pointNumberColor fontSize:7.0];
                    }
                        break;
                    case LineChartQuadrantType_FirstSecond:{
                        NSString * str = (j < [_xLineDataArray[0] count] ? (_xLineDataArray[0][j]) : (_xLineDataArray[1][j - [_xLineDataArray[0] count]]));
                        [self drawText:[NSString stringWithFormat:@"(%@,%@)",str,_valueArray[i][j]] context:context point:point color:pointNumberColor fontSize:7.0];
                    }
                        break;
                    case LineChartQuadrantType_FirstFourth:{
                        [self drawText:[NSString stringWithFormat:@"(%@,%@)",_xLineDataArray[j],_valueArray[i][j]] context:context point:point color:pointNumberColor fontSize:7.0];
                    }
                        break;
                    case LineChartQuadrantType_All:{
                        NSString * str = (j < [_xLineDataArray[0] count] ? (_xLineDataArray[0][j]) : (_xLineDataArray[1][j - [_xLineDataArray[0] count]]));
                        [self drawText:[NSString stringWithFormat:@"(%@,%@)",str,_valueArray[i][j]] context:context point:point color:pointNumberColor fontSize:7.0];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
    _isEndAnimation = NO;
}
#pragma mark --- reset parents' method
- (void)clear{
    _valueArray = nil;
    _drawDataArray = nil;
    for (CALayer * layer in _layerArray) {
        [layer removeFromSuperlayer];
    }
    [self showAnimation];
}
- (void)showAnimation{
    [self configPerXAndPery];
    [self configValueDataArray];
    [self drawAnimation];
}
- (void)drawAnimation{
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = [CAShapeLayer layer];
    if (_drawDataArray.count == 0) return;
    
    //一、UIBezierPath绘制线段
    [self configPerXAndPery];
    for (NSInteger i = 0; i < _drawDataArray.count; i ++) {
        NSArray * dataArray = _drawDataArray[i];
        [self drawPathWithDataArray:dataArray andIndex:i];
    }
}
- (void)drawPathWithDataArray:(NSArray *)dataArray andIndex:(NSInteger)colorIndex{
    UIBezierPath * firstPath = [UIBezierPath bezierPathWithOvalInRect:CGRectZero];
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        NSValue * value = dataArray[i];
        CGPoint point = value.CGPointValue;
        
        if (i ==0) {
            [firstPath moveToPoint:point];
        }else{
            [firstPath addLineToPoint:point];
        }
        [firstPath moveToPoint:point];
    }
    
    //二、UIBezierPath和CAShapeLayer关联
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = firstPath.CGPath;
    UIColor * color = (_valueLineColorArray.count == _drawDataArray.count ? (_valueLineColorArray[colorIndex]) : ([UIColor orangeColor]));
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = (_animationPathWidth <= 0? 2:_animationPathWidth);
    
    //三、动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer:shapeLayer];
    [_layerArray addObject:shapeLayer];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self drawPoint];
    }
}
/** 绘制值的点*/
- (void)drawPoint{
    for (NSInteger i = 0; i < _drawDataArray.count; i ++) {
        NSArray * array = _drawDataArray[i];
        for (NSInteger j =0; j < array.count; j ++) {
            NSValue * value = array[j];
            CGPoint point = value.CGPointValue;
            
            UIBezierPath * bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 5, 5)];
            [bezier moveToPoint:point];
            CAShapeLayer * layer = [CAShapeLayer layer];
            layer.frame = CGRectMake(0, 0, 5, 5);
            layer.position = point;
            layer.path = bezier.CGPath;
            
            UIColor * color = _pointColorArray.count == _drawDataArray.count ? (_pointColorArray[i]):([UIColor orangeColor]);
            layer.fillColor = color.CGColor;
            CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
            animation.fromValue = @0;
            animation.toValue = @1;
            animation.duration = 1;
            [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
            [self.layer addSublayer:layer];
            [_layerArray addObject:layer];
        }
        _isEndAnimation = YES;
        [self setNeedsDisplay];
    }
}
@end
