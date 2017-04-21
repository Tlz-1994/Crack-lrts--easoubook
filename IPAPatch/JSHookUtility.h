//
//  JSHookUtility.h
//  JumpUpAndDown
//
//  Created by stefanie on 16/6/8.
//  Copyright © 2016年 stefanie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSHookUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
