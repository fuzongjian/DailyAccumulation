//
//  BoxView.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoxView;
@protocol BoxViewDelegate <NSObject>
- (void)boxView:(BoxView *)boxView didSelectedIndexTag:(NSInteger)indexTag;
- (void)boxView:(BoxView *)boxView beginMoveIndexTag:(NSInteger)indexTag;
- (void)boxView:(BoxView *)boxView longGesture:(UILongPressGestureRecognizer *)gesture;
- (void)boxView:(BoxView *)boxView endMoveIndexTag:(NSInteger)indexTag;
@end
@interface BoxView : UIView
@property (nonatomic,assign) id <BoxViewDelegate>  delegate;
@property (nonatomic,assign) CGPoint viewPoint;
- (instancetype)initWithFrame:(CGRect)frame contentTitle:(NSString *)title;
@end
