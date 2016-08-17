//
//  PasswordView.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/17.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^completionBlock) (NSString *password);
@interface PasswordView : UIView
@property (nonatomic,copy) completionBlock completion;
+ (void)showOnView:(UIView *)view completion:(completionBlock)completion;
@end
