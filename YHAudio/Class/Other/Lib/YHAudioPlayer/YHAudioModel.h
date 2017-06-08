//
//  YHAudioModel.h
//  YHAudio
//
//  Created by harry on 2017/6/8.
//  Copyright © 2017年 harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

typedef void(^YHAudioPlayerDidFinishedPlaySoundBlock) (SystemSoundID soundID, NSString *soundFileName);

@interface YHAudioModel : NSObject
@property (nonatomic, assign) SystemSoundID soundID;
@property (nonatomic, copy) NSString *soundFileName;
@property (nonatomic, copy) YHAudioPlayerDidFinishedPlaySoundBlock finishPlayBlock;

+ (instancetype)modelWithSoundID:(SystemSoundID)soundID soundFileName:(NSString *)soundFileName finishPlayBlock:(YHAudioPlayerDidFinishedPlaySoundBlock)finishPlayBlock;

@end
