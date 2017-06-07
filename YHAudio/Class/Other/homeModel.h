//
//  homeModel.h
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//  首页表格的数据模型类

#import <Foundation/Foundation.h>

@interface homeModel : NSObject

/** 第一标题 */
@property (nonatomic, copy) NSString *title;

/** 第二标题 */
@property (nonatomic, copy) NSString *subTiele;

/** 对应的控制器类 */
@property (nonatomic, strong) Class tarClass;

/** 创建一个数据模型 */
+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTtitle tarClass:(Class)tarClass;

@end
