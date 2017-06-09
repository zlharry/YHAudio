//
//  YHMusicPlayer.m
//  YHAudio
//
//  Created by harry on 2017/6/9.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "YHMusicPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface YHMusicPlayer () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *musicPlayer;
/** 当前资源的总时长 */
@property (nonatomic, readwrite, assign) CGFloat duration;

@property (nonatomic, copy) YHMusicPlayerScaleChangedBlock playerScaleChangedBlock;
@property (nonatomic, copy) YHMusicPlayerDidFinishPlayingBlock playerDidFinishPlayingBlock;

/** 定时监测进度的定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YHMusicPlayer

- (instancetype)initWihtLocalMusicUrl:(NSURL *)localMusicUrl
              playerScaleChangedBlock:(YHMusicPlayerScaleChangedBlock)playerScaleChangedBlock
          playerDidFinishPlayingBlock:(YHMusicPlayerDidFinishPlayingBlock)playerDidFinishPlayingBlock
{
    if (self = [super init]) {
        
        self.localMusicUrl = localMusicUrl;
        self.playerScaleChangedBlock = playerScaleChangedBlock;
        self.playerDidFinishPlayingBlock = playerDidFinishPlayingBlock;
    }
    return self;
}
+ (instancetype)playerWihtLocalMusicUrl:(NSURL *)localMusicUrl
                playerScaleChangedBlock:(YHMusicPlayerScaleChangedBlock)playerScaleChangedBlock
            playerDidFinishPlayingBlock:(YHMusicPlayerDidFinishPlayingBlock)playerDidFinishPlayingBlock
{
    return [[self alloc] initWihtLocalMusicUrl:localMusicUrl playerScaleChangedBlock:playerScaleChangedBlock playerDidFinishPlayingBlock:playerDidFinishPlayingBlock];
}

- (void)setLocalMusicUrl:(NSURL *)localMusicUrl
{
    _localMusicUrl = localMusicUrl;
    
    [self.timer invalidate];
    self.timer = nil;
    
    NSError *error = nil;
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:localMusicUrl error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    self.duration = self.musicPlayer.duration;
    self.musicPlayer.numberOfLoops = 0; // 重复播放的次数
    self.musicPlayer.delegate = self;   // 设置代理
    [self.musicPlayer prepareToPlay];   // 加载到缓存，准备播放
    [self updateScale];
}

- (void)play
{
    if (!self.musicPlayer.isPlaying) {
        [self.musicPlayer play];
        self.timer.fireDate = [NSDate distantPast];
    }
    
}

- (void)pause
{
    
    if (self.musicPlayer.isPlaying) {
        [self.musicPlayer pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)stop
{
    self.localMusicUrl = self.localMusicUrl;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.musicPlayer.currentTime = self.musicPlayer.duration * scale;
}

- (BOOL)isPlaying
{
    return [self.musicPlayer isPlaying];
}

#pragma makr  - 延迟加载
- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(updateScale)
                                                userInfo:nil
                                                 repeats:true];
    }
    
    return _timer;
}

#pragma mark - 私有工具方法
- (void)updateScale
{
    self.scale = self.musicPlayer.currentTime / self.musicPlayer.duration;
    if (self.playerScaleChangedBlock) {
        self.playerScaleChangedBlock(self.scale);
    }
}

#pragma mark - AVAudioPlayerDelegate
/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (self.playerDidFinishPlayingBlock) {
        self.playerDidFinishPlayingBlock();
    }
    [self.timer invalidate];
    self.timer = nil;
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
}

@end
