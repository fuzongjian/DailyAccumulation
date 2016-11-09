//
//  CountdownView.h
//  testCount
//
//  Created by 付宗建 on 16/11/9.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountdownViewDelegate <NSObject>
- (void)CountDownFinish;
@end
@interface CountdownView : UIView
@property (nonatomic,assign) id <CountdownViewDelegate> delegate;
@property (nonatomic,assign) int  count;
- (void)start;
- (void)stop;
@end
