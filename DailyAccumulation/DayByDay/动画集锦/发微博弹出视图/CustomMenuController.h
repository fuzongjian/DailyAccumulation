//
//  CustomMenuController.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@protocol CustomMenuDelegate <NSObject>
- (void)customMenuDidTapClickBackground;
- (void)customMenuDidTapOnItem:(MenuItem *)item;
@end
@interface MenuItem : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) UIImage * icon;
@end
@interface CustomMenuController : UIViewController
@property (nonatomic,assign) id <CustomMenuDelegate> delegate;
@property (nonatomic,strong) NSArray * menuItemArray;
- (instancetype)initWithMenuItems:(NSArray *)menuItems;
@end
