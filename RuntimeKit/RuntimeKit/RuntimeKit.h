//
//  RuntimeKit.h
//  RuntimeKit
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 Mr.chi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeKit : NSObject

/**
 获取类名
 
 @param class 相应类
 @return NSString：类名
 */
+ (NSString *)getClassName:(Class)class;

/**
 获取成员变量
 
 @param class 成员变量所在的类
 @return 返回成员变量字符串数组
 */
+ (NSArray *)getIvarList:(Class)class;

/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param class Class
 @return 属性列表数组
 */
+ (NSArray *)getPropertyList:(Class)class;

/**
 获取类的实例方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param class <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)getMethodList:(Class)class;

/**
 往类上添加新的方法与其实现
 
 @param class 相应的类
 @param methodSel 方法的名
 @param methodSelImp 对应方法实现的方法名
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImp;

@end
