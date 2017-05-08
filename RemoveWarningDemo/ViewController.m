//
//  ViewController.m
//  RemoveWarningDemo
//
//  Created by syl on 2017/5/9.
//  Copyright © 2017年 personCompany. All rights reserved.
//

#import "ViewController.h"
#define SuppressPerformSelectorLeakWarning(Stuff)\
do{\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored\"-Warc-performSelector-leaks\"")\
Stuff;\
_Pragma("clang diagnostic pop")\
}while(0)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //去除用performSeletor方法执行的未实现，或者不可知其是否实现方法的警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(@"testMethod")];
#pragma clang diagnostic pop
    //也可定义一个宏定义
    SuppressPerformSelectorLeakWarning([self performSelector:NSSelectorFromString(@"testMethod")]);
    //也可以通过IMP的方式处理
    IMP imp = [self methodForSelector:NSSelectorFromString(@"testMethod")];
    void(*func)()= (void *)imp;
    func();
/*
    clang diagnostic的使用格式
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "要忽略的命令"
     需要处理的代码
    #pragma clang diagnostic pop
 
    忽略方法弃用的警告
    -Wdeprecated-declarations
    忽略不兼容指针类型
    -Wincompatible-pointer-type
    循环引用的警告
    -Warc-retain-cycles
    忽略未使用变量警告
    -Wunused-variable
    忽略未使用default 警告
    -Wcovered-switch-default
    
 */
    
}
-(void)testMethod
{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
