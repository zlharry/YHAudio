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
    [_audioIDs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        YHAudioModel *model = (YHAudioModel *)obj;
        if (model.soundID == soundID) {
            if (model.finishPlayBlock) {
                model.finishPlayBlock(model.soundID, model.soundFileName);
            }
        }
    }];
}

/** 通过资源文件名播放一段提示音 */
+ (void)playShortSoundWithSoundFileName:(NSString *)soundFileName finishPlayBlock:(YHAudioPlayerDidFinishedPlaySoundBlock)finishPlayBlock
{
    // 获取系统声音ID
    YHAudioModel *audioModel = [self soundIDWithAudioName:soundFileName finishPlayBlock:finishPlayBlock];
    // 播放音效
    AudioServicesPlaySystemSound(audioModel.soundID);
}

+ (YHAudioModel *)soundIDWithAudioName:(NSString *)audioName finishPlayBlock:(YHAudioPlayerDidFinishedPlaySoundBlock)finishPlayBlock
{
    
    // 如果没有加载过了
    if (!_audioIDs[audioName])
    {
        NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
        NSURL *audioFileUrl = [NSURL fileURLWithPath:audioFilePath];
        
        // 获取系统声音ID
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(audioFileUrl), &soundID);
        
        AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallback, NULL);
        
        _audioIDs[audioName] = [YHAudioModel modelWithSoundID:soundID soundFileName:audioName finishPlayBlock:finishPlayBlock];
    }
    
    return _audioIDs[audioName];
}

@end
