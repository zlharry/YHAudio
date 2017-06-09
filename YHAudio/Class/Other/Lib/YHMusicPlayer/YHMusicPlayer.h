//
//  YHMusicPlayer.h
//  YHAudio
//
//  Created by harry on 2017/6/9.
//  Copyright © 2017年 harry. All rights reserved.
//  一个音乐播放器类

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef void(^YHMusicPlayerScaleChangedBlock) (CGFloat scale);
typedef void(^YHMusicPlayerDidFinishPlayingBlock) ();

@interface YHMusicPlayer : NSObject

/** 播放的音乐本地路径 */
@property (nonatomic, strong) NSURL *localMusicUrl;

/** 进度 */
@property (nonatomic, assign) CGFloat scale;
/** 当前资源的总时长 */
@property (nonatomic, readonly, assign) CGFloat duration;

/** 播放器是否正在播放 */
@property (nonatomic, readonly, assign) BOOL isPlaying;

- (instancetype)initWihtLocalMusicUrl:(NSURL *)localMusicUrl
              playerScaleChangedBlock:(YHMusicPlayerScaleChangedBlock)playerScaleChangedBlock
          playerDidFinishPlayingBlock:(YHMusicPlayerDidFinishPlayingBlock)playerDidFinishPlayingBlock;
+ (instancetype)playerWihtLocalMusicUrl:(NSURL *)localMusicUrl
                playerScaleChangedBlock:(YHMusicPlayerScaleChangedBlock)playerScaleChangedBlock
            playerDidFinishPlayingBlock:(YHMusicPlayerDidFinishPlayingBlock)playerDidFinishPlayingBlock;

/** 开始播放 */
- (void)play;

/** 暂停 */
- (void)pause;

/** 停止播放 */
- (void)stop;

@end
