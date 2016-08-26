//
//  weakStrongModel.h
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^modelBlock) (void);
@interface weakStrongModel : NSObject
@property (nonatomic,copy) modelBlock block;
@property (nonatomic,copy) NSString * name;
@end
