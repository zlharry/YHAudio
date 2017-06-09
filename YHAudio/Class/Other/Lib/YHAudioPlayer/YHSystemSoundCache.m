//
//  YHSystemSoundCache.m
//  YHAudio
//
//  Created by harry on 2017/6/9.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "YHSystemSoundCache.h"

@interface YHSystemSoundCache ()

/** 音效 ID 缓存数组 */
@property (nonatomic, strong) NSMutableDictionary *soundIDs;

@end

@implementation YHSystemSoundCache

/** 获取一个单例对象 */
+ (instancetype)shareSystemSoundCache
{
    static YHSystemSoundCache *systemSoundCache = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,
                  ^{
                      systemSoundCache = [[self alloc] init];
                  });
    return systemSoundCache;
}

#pragma mark - 延迟加载
- (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}

#pragma mark - 外部接口
/** 通过本地文件名获取一个音效ID */
+ (SystemSoundID)soundIDWithFileName:(NSString *)fileName
{
    NSURL *fileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
    return [self soundIDWithhLocalFileUrl:fileUrl];
}

+ (SystemSoundID)soundIDWithhLocalFileUrl:(NSURL *)localFileUrl
{
    YHSystemSoundCache *cache = [self shareSystemSoundCache];
    NSString *key = localFileUrl.path;
    
    // 如果没有缓存就创建一个后返回
    if (!cache.soundIDs[key])
    {
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(localFileUrl), &soundID);
        
        cache.soundIDs[key] = @(soundID);
        return soundID;
    }
    else
    {
        return [cache.soundIDs[key] unsignedIntValue];
    }
    
    // 如果有就直接返回
    return 0;
}

/** 清空所有的ID缓存 */
+ (void)clearCache { [[[self shareSystemSoundCache] soundIDs] removeAllObjects];}

@end
