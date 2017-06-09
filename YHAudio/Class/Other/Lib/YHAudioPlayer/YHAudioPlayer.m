//
//  YHAudioPlayer.m
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "YHAudioPlayer.h"

@interface YHAudioPlayer ()

@property (nonatomic, copy) YHAudioPlayerDidFinishedPlaySoundBlock finishPlayBlock;

@end


@implementation YHAudioPlayer

/** 通过资源文件名播放一段提示音 */
+ (void)playShortSoundWithSoundFileName:(NSString *)soundFileName shake:(BOOL)shake finishPlayBlock:(YHAudioPlayerDidFinishedPlaySoundBlock)finishPlayBlock;
{
    SystemSoundID soundID = [YHSystemSoundCache soundIDWithFileName:soundFileName];
    
    // 播放音效
    if (shake)
    {
        AudioServicesPlayAlertSoundWithCompletion(soundID,
                                                  ^{
                                                      if (finishPlayBlock) {
                                                          finishPlayBlock(soundID);
                                                      }
                                                  });
    }
    else
    {
        AudioServicesPlaySystemSoundWithCompletion(soundID,
                                                   ^{
                                                       if (finishPlayBlock) {
                                                           finishPlayBlock(soundID);
                                                       }
                                                   });
    }
    
}

@end
