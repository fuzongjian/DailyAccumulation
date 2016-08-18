//
//  DragBoxController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "DragBoxController.h"
#import "BoxView.h"
#define BOX_WIDTH SCREEN_WIDTH / 4 // 格子高宽
#define PREFIX_TAG 112325
@interface DragBoxController ()<BoxViewDelegate>
@property (nonatomic,strong) NSArray * contentArray;
@property (nonatomic,strong) NSMutableArray * boxViewArray;
@property (nonatomic,strong) UIScrollView * contentScroll;
@property (nonatomic,assign) CGPoint  selectedCenter;
@end
@implementation DragBoxController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configDragBoxControllerUI];
}
- (void)configDragBoxControllerUI{
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000]];
//    // 标题字体和颜色
//    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                [UIColor whiteColor], NSForegroundColorAttributeName,
//                                [UIFont boldSystemFontOfSize:21], NSFontAttributeName,
//                                nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1.];
    self.contentArray = [NSArray arrayWithObjects:@"求",@"知",@"若",@"渴",@"，",@"虚",@"怀",@"若",@"谷",@"。", nil];
    [self configBoxViewUI];
}
- (void)configBoxViewUI{
    // 容器

    [self.view addSubview:self.contentScroll];
    
    // 格子布局
    CGFloat widthx = 0,heighty = 0;
    for (int i = 0; i < self.contentArray.count; i ++) {
        BoxView * boxView = [[BoxView alloc] initWithFrame:CGRectMake(widthx, heighty, BOX_WIDTH - 1, BOX_WIDTH - 1) contentTitle:[self.contentArray objectAtIndex:i]];
        boxView.delegate = self;
        boxView.tag = PREFIX_TAG + i;
        boxView.viewPoint = boxView.center;
        [self.boxViewArray addObject:boxView];
        [self.contentScroll addSubview:boxView];
        widthx = widthx + BOX_WIDTH;
        if (widthx == SCREEN_WIDTH) {
            widthx = 0;
            heighty += BOX_WIDTH;
        }
    }
    self.contentScroll.contentSize = CGSizeMake(SCREEN_WIDTH, heighty);
    
}
#pragma mark --- BoxView delegate
- (void)boxView:(BoxView *)boxView didSelectedIndexTag:(NSInteger)indexTag{
    NSLog(@"选中了第%d个格子",indexTag - PREFIX_TAG);
}
- (void)boxView:(BoxView *)boxView beginMoveIndexTag:(NSInteger)indexTag{
    [self.contentScroll bringSubviewToFront:boxView];
    self.selectedCenter = boxView.viewPoint;
    boxView.transform = CGAffineTransformMakeScale(1.1, 1.1);
}
- (void)boxView:(BoxView *)boxView longGesture:(UILongPressGestureRecognizer *)gesture{
    // 移动前的tag值
    NSInteger formTag = boxView.tag;
    // 移动坐标
    CGPoint newPoint = [gesture locationInView:self.contentScroll];
    // X,Y
    CGFloat moveX = newPoint.x - boxView.frame.origin.x;
    CGFloat moveY = newPoint.y - boxView.frame.origin.y;
    //跟随手势移动
    boxView.center = CGPointMake(boxView.center.x + moveX - BOX_WIDTH / 2, boxView.center.y + moveY - BOX_WIDTH / 2);
    //目标位置
    NSInteger (^getToTag)(void) = ^{
        for (int i = 0; i < self.boxViewArray.count; i ++) {
            UIView * view = [self.boxViewArray objectAtIndex:i];
            if ((view != boxView) && (CGRectContainsPoint(view.frame, boxView.center))){
                return i + PREFIX_TAG;
            }
        }
        return -100;
    };
    //处理tag值和中心位置
    void (^manageTagCenter)(void) = ^{
        for (int i = 0; i < self.boxViewArray.count; i ++) {
            BoxView * view = [self.boxViewArray objectAtIndex:i];
            view.tag = PREFIX_TAG + i;
            view.viewPoint = view.center;
        }
    };
    NSInteger toTag = getToTag();
    //向前拖动
    if (toTag < formTag && toTag >= 0) {
        BoxView * toView = [self.boxViewArray objectAtIndex:toTag - PREFIX_TAG];
        boxView.center = toView.viewPoint;
        self.selectedCenter = toView.viewPoint;
        for (int j = formTag - PREFIX_TAG ; j > toTag - PREFIX_TAG; j--) {
            BoxView * boxOne = [self.boxViewArray objectAtIndex:j];
            BoxView * boxTwo = [self.boxViewArray objectAtIndex:j -1];
            [UIView animateWithDuration:.5 animations:^{
                boxTwo.center = boxOne.viewPoint;
            }];
        }
        //处理数据
        [self.boxViewArray removeObject:boxView];
        [self.boxViewArray insertObject:boxView atIndex:toTag - PREFIX_TAG];
        manageTagCenter();
    }
    
    //向后拖动
    if (toTag > formTag && toTag - PREFIX_TAG < self.boxViewArray.count) {
        BoxView * toView = [self.boxViewArray objectAtIndex:toTag - PREFIX_TAG];
        boxView.center = toView.viewPoint;
        self.selectedCenter = toView.viewPoint;
        for (int j = formTag - PREFIX_TAG; j < toTag - PREFIX_TAG; j ++) {
            BoxView * boxOne = [self.boxViewArray objectAtIndex:j];
            BoxView * boxTwo = [self.boxViewArray objectAtIndex:j + 1];
            [UIView animateWithDuration:.5 animations:^{
                boxTwo.center = boxOne.viewPoint;
            }];
        }
        [self.boxViewArray removeObject:boxView];
        [self.boxViewArray insertObject:boxView atIndex:toTag - PREFIX_TAG];
        manageTagCenter();
    }
    
    
}
- (void)boxView:(BoxView *)boxView endMoveIndexTag:(NSInteger)indexTag{
    boxView.center = self.selectedCenter;
    boxView.transform = CGAffineTransformIdentity;
}
-(NSMutableArray *)boxViewArray{
    if (_boxViewArray == nil) {
        _boxViewArray = [NSMutableArray array];
    }
    return _boxViewArray;
}
- (UIScrollView *)contentScroll{
    if (_contentScroll == nil) {
        _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _contentScroll.backgroundColor = [UIColor colorWithWhite:.9 alpha:.1];
        _contentScroll.scrollEnabled = YES;
    }
    return _contentScroll;
}
@end
