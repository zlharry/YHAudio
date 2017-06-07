//
//  homeModel.m
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "homeModel.h"

@implementation homeModel



/** 创建一个数据模型 */
- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTtitle tarClass:(Class)tarClass
{
    if (self = [super init]) {
        self.title = title;
        self.subTiele = subTtitle;
        self.tarClass = tarClass;
    }
    
    return self;
}

/** 创建一个数据模型 */
+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTtitle tarClass:(Class)tarClass
{
    return [[self alloc] initWithTitle:title subTitle:subTtitle tarClass:tarClass];
}
@end
