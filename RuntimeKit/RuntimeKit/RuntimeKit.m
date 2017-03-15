//
//  RuntimeKit.m
//  RuntimeKit
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 Mr.chi. All rights reserved.
//

#import "RuntimeKit.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation RuntimeKit

+(NSString *)getClassName:(Class)class {
    
    //俩种方法都可以
    //const char *className = object_getClassName(class);
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

+(NSArray *)getIvarList:(Class)class {
    
    unsigned int count = 0;
    NSMutableArray * mutabList = [NSMutableArray arrayWithCapacity:count];
    Ivar * ivars = class_copyIvarList(class, &count);
    for (unsigned int i = 0; i < count; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivars[i]);
        const char *type = ivar_getTypeEncoding(ivars[i]);
        dict[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        dict[@"type"] = [NSString stringWithUTF8String: type];
        [mutabList addObject:dict];
    }
    free(ivars);
    return mutabList.copy;
}

+ (NSArray *)getPropertyList:(Class)class {
    
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)getMethodList:(Class)class {
    
    unsigned int count = 0;
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    Method *methodList = class_copyMethodList(class, &count);
    for (unsigned int i = 0; i < count; i ++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return mutableList.copy;
}

+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImp{

    Method method = class_getInstanceMethod(class, methodSelImp);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
    
}



@end
