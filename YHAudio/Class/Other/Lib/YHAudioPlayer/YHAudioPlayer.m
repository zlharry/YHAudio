//
//  YHAudioPlayer.m
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "YHAudioPlayer.h"

#import <AudioToolbox/AudioToolbox.h>

@interface YHAudioPlayer ()

@end

NSMutableDictionary *_audioIDs;

@implementation YHAudioPlayer

+ (void)initialize
{
    if (!_audioIDs) {_audioIDs = [NSMutableDictionary dictionary];}
}

/** 提示音播放完成后的回调 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    
    NSLog(@"%d", soundID);
    NSLog(@"%@", clientData);
}

/** 通过资源文件名播放一段提示音 */
+ (void)playShortSoundWithSoundFileName:(NSString *)soundFileName
{
    // 获取系统声音ID
    SystemSoundID soundID = [self soundIDWithAudioName:soundFileName];
    
    // 设置回调函数
    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallback,NULL);
    
    // 播放音效
    AudioServicesPlaySystemSound(soundID);
}

+ (SystemSoundID)soundIDWithAudioName:(NSString *)audioName
{
    SystemSoundID soundID = 0;
    
    // 如果已经加载过了
    if ((soundID = [_audioIDs[audioName] unsignedIntValue]) != 0)
    {
        return soundID;
    }
    // 如果没有加载过
    else
    {
        NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
        NSURL *audioFileUrl = [NSURL fileURLWithPath:audioFilePath];
        
        // 获取系统声音ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(audioFileUrl), &soundID);
        
        _audioIDs[audioName] = @(soundID);
    }
    
    return soundID;
}

@end
