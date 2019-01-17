//
//  TZLKVCViewController.m
//  Demos
//
//  Created by tang on 2018/11/30.
//  Copyright © 2018年 TZL. All rights reserved.
//
//程序优先调用set<Key>:属性值方法，代码通过setter方法完成设置。注意，这里的<key>是指成员变量名，首字母大小写要符合KVC的命名规则，下同。

//如果没有找到setName：方法，KVC机制会检查+ (BOOL)accessInstanceVariablesDirectly方法有没有返回YES，默认该方法会返回YES，如果你重写了该方法让其返回NO的话，那么在这一步KVC会执行setValue：forUndefinedKey：方法，不过一般开发者不会这么做。所以KVC机制会搜索该类里面有没有名为_<key>的成员变量，无论该变量是在类接口处定义，还是在类实现处定义，也无论用了什么样的访问修饰符，只在存在以_<key>命名的变量，KVC都可以对该成员变量赋值。

//如果该类即没有set<key>：方法，也没有_<key>成员变量，KVC机制会搜索_is<Key>的成员变量。

//和上面一样，如果该类即没有set<Key>：方法，也没有_<key>和_is<Key>成员变量，KVC机制再会继续搜索<key>和is<Key>的成员变量。再给它们赋值。

//如果上面列出的方法或者成员变量都不存在，系统将会执行该对象的setValue：forUndefinedKey：方法，默认是抛出异常。

//特别需要注意的是：如果开发者想让这个类禁用KVC里，那么重写+ (BOOL)accessInstanceVariablesDirectly方法让其返回NO即可，这样的话如果KVC没有找到set<Key>:属性名时，会直接用setValue：forUndefinedKey：方法。


#import "TZLKVCViewController.h"

#import "TZLPerson.h"

@interface TZLKVCViewController () {
    NSString *name;
    
    NSString *_name;
    NSString *_isAge;
    NSString *hegith;
    NSString *isWight;
}

@end

@implementation TZLKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.index == 0) {//把accessInstanceVariablesDirectly方法注释放开
        [self setValue:@"小明明" forKey:@"name"];
        NSLog(@"%@", name);
    }
    
    if (self.index == 1) {
        [self setValue:@"小明明" forKey:@"name"];
        NSLog(@"%@", _name);
    }
    if (self.index == 2) {
        [self setValue:@"小明明" forKey:@"age"];
        NSLog(@"%@", _isAge);
    }
    if (self.index == 3) {
        [self setValue:@"22" forKey:@"hegith"];
        NSLog(@"%@", hegith);
    }
    if (self.index == 4) {
        [self setValue:@"小明明" forKey:@"wight"];
        NSLog(@"%@", isWight);
    }
    
    if (self.index == 5) {
        TZLPerson *person = [TZLPerson new];
        [person setValue:@"我就改你名字" forKey:@"name"];
        NSString *name = [person valueForKey:@"name"];
        NSLog(@"%@", name);
    }
    
    if (self.index == 6) {
        NSArray *arr = @[@"john", @"tom", @"lucy", @"lily"];
        NSArray *captainArr = [arr valueForKey:@"capitalizedString"];
        NSLog(@"captainArr = %@", captainArr);
        
        NSArray *lengthArr = [arr valueForKeyPath:@"capitalizedString.length"];
        NSLog(@"lengthArr = %@",lengthArr);
        
    }
    
    if (self.index == 7) {
        TZLPerson *book1 = [TZLPerson new];
        book1.head = @"The Great Gastby";
        book1.price = 22;
        
        TZLPerson *book2 = [TZLPerson new];
        book2.head = @"Time History";
        book2.price = 12;
        
        TZLPerson *book3 = [TZLPerson new];
        book3.head = @"Wrong Hole";
        book3.price = 111;
        
        TZLPerson *book4 = [TZLPerson new];
        book4.head = @"Wrong Hole";
        book4.price = 111;
        
        NSArray* arrBooks = @[book1,book2,book3,book4];
        NSNumber* sum = [arrBooks valueForKeyPath:@"@sum.price"];
        NSLog(@"sum:%f",sum.floatValue);
        
        NSNumber* avg = [arrBooks valueForKeyPath:@"@avg.price"];
        NSLog(@"avg:%f",avg.floatValue);
        
        NSNumber* count = [arrBooks valueForKeyPath:@"@count"];
        NSLog(@"count:%f",count.floatValue);
        
        NSNumber* min = [arrBooks valueForKeyPath:@"@min.price"];
        NSLog(@"min:%f",min.floatValue);
        
        NSNumber* max = [arrBooks valueForKeyPath:@"@max.price"];
        NSLog(@"max:%f",max.floatValue);
    }
}

//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
     NSLog(@"没有找到该key对应的属性会抛出异常");
}

@end
