//
//  TZLBlock1ViewController.m
//  Demos
//
//  Created by tang on 2019/1/11.
//  Copyright © 2019年 TZL. All rights reserved.
//

#import "TZLBlock1ViewController.h"

@interface TZLBlock1ViewController ()

@end

@implementation TZLBlock1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSLog(@"------------------a0-----------------");
    NSInteger a0 = 10;
    NSLog(@"定义前:%p", &a0);// 栈区 指的是指针在栈区的地址
    void (^foo0)(void) = ^{
        
        NSLog(@"block内部:%p", &a0);// 堆区 a这个“外部变量”在栈中的内存地址被捕获一份(本身未变)放到了堆   由于arc下自动copy的y作用
    };
    NSLog(@"定义后:%p", &a0);// 栈区 指的是指针在栈区的地址
    foo0();
    NSLog(@"定义后并且调用后:%p", &a0);// 栈区 指的是指针在栈区的地址
    
    
    NSLog(@"------------------a-----------------");
    __block NSInteger a = 10;
    NSLog(@"定义前:%p", &a);// 栈区 指的是指针在栈区的地址
    void (^foo)(void) = ^{
        a = 8;
        NSLog(@"block内部:%p", &a);// 堆区 a这个“外部变量”在栈中的内存地址放到了堆
    };
    NSLog(@"定义后:%p", &a);// 堆区 __block修饰使a本身已经不再栈区了 已经被改到堆中了
    foo();
    NSLog(@"定义后并且调用后:%p", &a);// 堆区 已经被改到堆中了
    
    NSLog(@"------------------b-----------------");
    NSMutableString *b = [[NSMutableString alloc] initWithString:@"我在block内之前"];
    NSLog(@"定义前b指向的堆中的地址:%p\n, b在栈中的指针地址:%p", b, &b);
    void (^bfoo)(void) = ^{
        b.string = @"我在block内";
        NSLog(@"block内b指向的堆中的地址:%p\n, b在堆中的指针地址:%p", b, &b);
        //b = [[NSMutableString alloc] initWithString:@"我在block内"];//这个是报错的
    };
    NSLog(@"定义后b指向的堆中的地址:%p\n, b在栈中的指针地址:%p", b, &b);
    bfoo();
    NSLog(@"定义后并且调用后b指向的堆中的地址:%p\n, b在栈中的指针地址:%p", b, &b);
    
    /*
     定义前b指向的堆中的地址:0x60000005db90
     , b在栈中的指针地址:0x7ffee2f113d8       140732705870808
     定义后b指向的堆中的地址:0x60000005db90
     , b在栈中的指针地址:0x7ffee2f113d8
     block内b指向的堆中的地址:0x60000005db90
     , b在堆中的指针地址:0x60000005cec0   105553116647104  (这个是在堆中了,说明没有用__block修饰的对象也会被复制一份到堆中)
     **/
    
    
    NSLog(@"------------------c-----------------");
    __block NSMutableString *c = [[NSMutableString alloc] initWithString:@"我在block内之前"];
    NSLog(@"定义前c指向的堆中的地址:%p\n, c在栈中的指针地址:%p", c, &c);
    void (^cfoo)(void) = ^{
        c.string = @"我在block内";
        NSLog(@"block内c指向的堆中的地址:%p\n, b在堆中的指针地址:%p", c, &c);
        c = [[NSMutableString alloc] initWithString:@"我在block内1"];//这个是可以的 只是让已经在堆h中的指针地址 指向了新的值地址
        NSLog(@"block内c指向的堆中的地址:%p\n, b在堆中的指针地址:%p", c, &c);
    };
    NSLog(@"定义后c指向的堆中的地址:%p\n, c在堆中的指针地址:%p", c, &c);
    cfoo();
    
    /*
     定义前c指向的堆中的地址:0x60000005e070
     , c在栈中的指针地址:0x7ffee2f113a0
     定义后c指向的堆中的地址:0x60000005e070
     , c在堆中的指针地址:0x60000005dbe8    解释: 这是变化 是由于c被block捕获 已经复制到堆中了
     block内c指向的堆中的地址:0x60000005e070  这个值地址不变 ,变化的是值本身
     , b在堆中的指针地址:0x60000005dbe8   和上面一样
     block内c指向的堆中的地址:0x60000005f150   新的值地址
     , b在堆中的指针地址:0x60000005dbe8  指针地址不变 指向的值地址变了
     **/
}



@end
