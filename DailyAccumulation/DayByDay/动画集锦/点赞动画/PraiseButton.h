//
//  PraiseButton.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PraiseButton;
@interface PraiseImageView : UIImageView
@end
@protocol PraiseDelegate <NSObject>
- (void)praiseButton:(PraiseButton *)praise didSelected:(BOOL)state;
@end
@interface PraiseButton : UIView
@property (nonatomic,assign) id <PraiseDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame normalImage:(UIImage *)norImage selectedImage:(UIImage *)selImage defaultCount:(NSInteger)defCount defaultSelected:(BOOL)state;
@end
