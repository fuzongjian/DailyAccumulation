//
//  CommonManager.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonManager : NSObject
/**判断手机号是否符合常规*/
- (BOOL)isMobileNumber:(NSString *)mobileNum;
/**判断邮箱是否符合常规*/
- (BOOL) isEmail:(NSString *)email;
/**动态计算字符串宽度*/
- (CGFloat)calculateWidthString:(NSString *)string textFont:(UIFont *)font height:(CGFloat)height;
/**动态计算字符串高度*/
- (CGFloat)calculateHeightString:(NSString *)string textFont:(UIFont *)font width:(CGFloat)width;
@end
