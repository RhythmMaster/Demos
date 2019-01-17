//
//  TZLBlockViewController.m
//  Demos
//
//  Created by tang on 2019/1/10.
//  Copyright © 2019年 TZL. All rights reserved.
//

#import "TZLBlockViewController.h"
typedef void (^DemoBlock5)(void);
@interface TZLBlockViewController ()
/**  */
@property(nonatomic, strong) DemoBlock5 DemoBlock5;
/**  */
@property(nonatomic, strong) DemoBlock5 DemoBlock6;
/**  */
@property(nonatomic, strong) DemoBlock5 DemoBlock7;
/**  */
@property(nonatomic, strong) DemoBlock5 DemoBlock9;
@end

@implementation TZLBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /*
     1.为什么block要用 copy修饰 在mrc下必须copy  在arc下可以strong 因为系统自己copy了
     结论:block 在mrc环境下
     DemoBlock内部没有调用外部变量时存放在全局区(ARC和MRC下均是)
     DemoBlock2使用了外部变量,这种情况也正式我们平时所常用的方式,Block的内存地址显示在栈区,栈区的特点就是创建的对象随时可能被销毁,一旦被销毁后续再次调用空对象就可能会造成程序崩溃,在对block进行copy后,block存放在堆区.所以在使用Block属性时使用Copy修饰,而在ARC模式下,系统也会默认对Block进行copy操作
     有个 疑问 但是如果是 self.block 如果调用 外部变量 则 还是 在堆区 不管 self.block 是strong还是copy修饰
     
     
     
     另外一种解释: copy修饰是因为防止block使用了 局部变量 某个方法的局部变量这种,只能在方法的的生命周期内存在,是存放在栈上的,当我们调用block的时候 可能已经出了方法的生命周期,而这时候局部变量被销毁了,就会出现crash.copy修饰 就会复制到堆上面 引用计数加一 不会被销毁
     __block修饰 是配合copy修饰的,不然无意义, 首先 因为copy修饰了 所以
     **/
    NSLog(@"-----------------------------------");
    //__NSGlobalBlock__ 全局区的 (没有引用外部变量)
    void (^DemoBlock)(void) = ^{
        NSLog(@"DemoBlock");
    };
    NSLog(@"%@",DemoBlock);
    
    int a = 6;
    //__NSStackBlock__ 栈区 (内部使用了外部变量)(MRC模式下)
    void (^DemoBlock2)(void) = ^{
        NSLog(@"DemoBlock2 %d",a + 5);
    };
    NSLog(@"DemoBlock2 %@",DemoBlock2);
    DemoBlock2();
    
    //__NSMallocBlock__ 堆区 ([DemoBlock2 copy]后Block存放在堆区)
    NSLog(@"DemoBlock2.Copy %@",[DemoBlock2 copy]);
    
    void (^DemoBLock3)(void) = [DemoBlock2 copy];
    NSLog(@"DemoBlock3 %@",DemoBLock3);
    
    void (^DemoBLock4)(void) = DemoBlock2;
    NSLog(@"DemoBlock4 %@",DemoBLock4);


    self.DemoBlock5 = ^{
        
    };
    NSLog(@"self.DemoBlock5 %@",self.DemoBlock5);
    
    int b = 10;
    self.DemoBlock6 = ^{
        NSLog(@"DemoBlock2 %p",&b);
        NSLog(@"DemoBlock2 %d",b + 5);
    };
    NSLog(@"self.DemoBlock6 %@",self.DemoBlock6);
    
    self.DemoBlock7 = [self.DemoBlock6 copy];
    NSLog(@"self.DemoBlock7 %@",self.DemoBlock7);
    
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:testBtn];
    [testBtn setTitle:@"触发self.DemoBlock6" forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(selfDemoBlock6) forControlEvents:UIControlEventTouchUpInside];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(100);
        make.centerX.equalTo(0);
    }];
    
    
    
   // 这个时候可能已经 DemoBlock2() 被销毁了 因为是在 栈区
    DemoBlock2();
    
    
    NSLog(@"未被block持有的引用计数:%ld", self.retainCount);
    void (^DemoBlock8)(void) = ^{
        NSLog(@"DemoBlock8%@",self);
    };
    NSLog(@"DemoBlock8 %@",DemoBlock8);
    NSLog(@"被block持有的引用计数:%ld", self.retainCount);
    
    NSLog(@"未被self.block持有的引用计数:%ld", self.retainCount);
    self.DemoBlock9 = ^{
        NSLog(@"self.DemoBlock9%@",self);
    };
    NSLog(@"self.DemoBlock9 %@",self.DemoBlock6);
    NSLog(@"被self.block持有的引用计数:%ld", self.retainCount);
}
- (void)selfDemoBlock6 {
    self.DemoBlock6();
}


@end
