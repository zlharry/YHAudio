//
//  YHAudioPlayer.h
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//  一个播放声音的工具

#import <Foundation/Foundation.h>

@interface YHAudioPlayer : NSObject

/** 通过资源文件名播放一段提示音 */
+ (void)playShortSoundWithSoundFileName:(NSString *)soundFileName;

@end
