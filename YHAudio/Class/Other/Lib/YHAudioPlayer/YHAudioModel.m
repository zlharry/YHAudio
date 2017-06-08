//
//  YHAudioModel.m
//  YHAudio
//
//  Created by harry on 2017/6/8.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "YHAudioModel.h"

@implementation YHAudioModel
+ (instancetype)modelWithSoundID:(SystemSoundID)soundID soundFileName:(NSString *)soundFileName finishPlayBlock:(YHAudioPlayerDidFinishedPlaySoundBlock)finishPlayBlock
{
    YHAudioModel *model = [[YHAudioModel alloc] init];
    
    model.soundID = soundID;
    model.soundFileName = soundFileName;
    model.finishPlayBlock = finishPlayBlock;
    
    return model;
}
@end
