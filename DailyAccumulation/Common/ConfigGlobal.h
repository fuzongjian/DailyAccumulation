//
//  ConfigGlobal.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#ifndef ConfigGlobal_h
#define ConfigGlobal_h
//屏幕宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//设备机型
#define iPHone6Plus ([UIScreen mainScreen].bounds.size.height == 736) ? YES : NO
#define iPHone6 ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO
#define iPHone5 ([UIScreen mainScreen].bounds.size.height == 568) ? YES : NO
#define iPHone4 ([UIScreen mainScreen].bounds.size.height == 480) ? YES : NO
//设备版本号码
#define IOSVERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
// 颜色简化
#define RGB(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
// 坐标输入简化
#define P_M(x,y) CGPointMake(x, y)
// 以iPhone5为基础做适配
#define FIX(widthorheight) (SCREEN_WIDTH > 320 ?  widthorheight * SCREEN_WIDTH/320.0 : widthorheight)
//偏好设置简化
#define kUserDefalutsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]
#define kUserDefaultsGet(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define kUserDefaultsSet(object,key)  [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
//加载
#define ShowActivityIndicator [UIApplication sharedApplication].networkActivityIndicatorVisible = YES ;
#define HideActivityIndicator [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;

//调试环境输出设置
#ifdef DEBUG
#define Log(...) NSLog(@"\n%s 第%d行 \n%@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define Log(...)
#endif
//弱引用、强引用
#define weakSelf(type)  __weak typeof(type) weak##type = type;
#define strongSelf(type)  __strong typeof(type) type = weak##type;





#endif /* ConfigGlobal_h */
