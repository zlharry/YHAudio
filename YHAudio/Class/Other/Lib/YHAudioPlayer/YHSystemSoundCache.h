//
//  YHSystemSoundCache.h
//  YHAudio
//
//  Created by harry on 2017/6/9.
//  Copyright © 2017年 harry. All rights reserved.
//  音效缓存类

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface YHSystemSoundCache : NSObject
/** 通过本地文件名获取一个音效ID */
+ (SystemSoundID)soundIDWithFileName:(NSString *)fileName;
+ (SystemSoundID)soundIDWithhLocalFileUrl:(NSURL *)localFileUrl;

/** 清空所有的ID缓存 */
+ (void)clearCache;
@end
