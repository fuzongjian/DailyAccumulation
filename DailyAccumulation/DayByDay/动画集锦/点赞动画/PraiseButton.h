//
//  PraiseButton.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/26.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PraiseImageView : UIImageView
@end
@interface PraiseButton : UIView
- (instancetype)initWithFrame:(CGRect)frame normalImage:(UIImage *)norImage selectedImage:(UIImage *)selImage defaultCount:(NSInteger)defCount;
@end
