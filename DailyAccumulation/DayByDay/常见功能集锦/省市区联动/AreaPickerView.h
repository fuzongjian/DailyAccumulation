//
//  AreaPickerView.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/18.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^completionBlock) (NSString * province,NSString * city,NSString * area);
@interface AreaPickerView : UIView
+ (void)showOnView:(UIView *)view completion:(completionBlock)completion;
@end
