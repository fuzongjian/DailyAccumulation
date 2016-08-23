//
//  weakStrongController.m
//  DailyAccumulation
//
//  Created by 付宗建 on 16/8/23.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "weakStrongController.h"
#import "weakStrongModel.h"
#define weakSelf(type) __weak __typeof(type) weak##type = type;
typedef void (^myBlock)(void);
@interface weakStrongController ()
@property (nonatomic,copy) myBlock blcok;
@property (nonatomic,copy) NSString * testStr;
@end

@implementation weakStrongController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self weakStrongMethod2];
    
    // Do any additional setup after loading the view.
}
- (void)weakStrongMethod2{
    /*
     1、在使用block时，如果block内部需要访问self的方法、属性、实例变量应该使用weakSelf
     2、如果在block内需要多次访问self，则需要使用strongSelf
     3、如果在block内部存在多线程环境访问self，则需要使用strongSelf
     4、block本身不攒子啊多线程之分，block执行是否多线程，取决于当前的持有者是否是以多线程的方式来调用它
     */
    
    
    __weak __typeof (self) weakSelf = self;
    
    self.blcok = ^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             Log(@"%@",weakSelf.testStr);
            __strong __typeof(self) strongSelf = weakSelf;
            [strongSelf weakStrongMethod1];
        });
//        [weakSelf weakStrongMethod1];
    };
    self.blcok();

}
- (void)weakStrongMethod1{
    /**
     *  @brief 这类block没有形成引用环，不能构成循环引用
     */
    void (^myBlock)(void) = ^{
        NSLog(@"%@",self.testStr);
    };
    myBlock();

}
- (NSString *)testStr{
    if (_testStr == nil) {
        _testStr = @"fuzongjian";
    }
    return _testStr;
}
- (void)dealloc{
    Log(@"测试block内存释放");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
