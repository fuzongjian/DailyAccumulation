//
//  AdvertScrollView.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/18.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, UIPageControlShowStyle)
{
    UIPageControlShowStyleNone,//default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};
@protocol AdScrollViewDelegate<NSObject>
-(void)didSelectAtIndex:(long)index;
@end
@interface AdvertScrollView : UIScrollView<UIScrollViewDelegate>
@property (retain,nonatomic,readonly) UIPageControl * pageControl;
@property (retain,nonatomic,readwrite) NSArray * bannerArray;
@property (assign,nonatomic,readwrite) UIPageControlShowStyle  PageControlShowStyle;
@property (strong, nonatomic) id<AdScrollViewDelegate> adDelegate;
@end
