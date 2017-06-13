//
//  PlayLocalMusicVC.m
//  YHAudio
//
//  Created by harry on 2017/6/9.
//  Copyright © 2017年 harry. All rights reserved.
//  一个播放本地音乐的播放器

#import "PlayLocalMusicVC.h"

#import "YHMusicPlayer.h"

@interface PlayLocalMusicVC ()
@property (nonatomic, strong) YHMusicPlayer *musicPlayer;

/** 播放／暂停按钮 */
@property (nonatomic, weak) UIButton *playPauseBtn;

/** 停止按钮 */
@property (nonatomic, weak) UIButton *stopBtn;

/** 进度条 */
@property (nonatomic, weak) UISlider *slider;

/** 播放器控制条背景 */
@property (nonatomic, weak) UIView *controlBackView;

@end

@implementation PlayLocalMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本地音乐播放器";
    
    
    [self setupFrames];
}

- (void)setupFrames
{
    CGFloat conX = 10;
    CGFloat conY = 80;
    CGFloat conW = self.view.frame.size.width - 2 * conX;
    CGFloat conH = 50;
    self.controlBackView.frame = CGRectMake(conX, conY, conW, conH);
    
    CGFloat palyPauseX = 0;
    CGFloat palyPauseY = 0;
    CGFloat palyPauseW = conH;
    CGFloat palyPauseH = conH;
    self.playPauseBtn.frame = CGRectMake(palyPauseX, palyPauseY, palyPauseW, palyPauseH);
    
    CGFloat stopX = palyPauseX + palyPauseW + 5;
    CGFloat stopY = palyPauseY;
    CGFloat stopW = palyPauseW;
    CGFloat stopH = palyPauseH;
    self.stopBtn.frame = CGRectMake(stopX, stopY, stopW, stopH);
    
    CGFloat slideX = stopX + stopW + 5;
    CGFloat slideY = 0;
    CGFloat slideW = conW - slideX - 5;
    CGFloat slideH = palyPauseH;
    self.slider.frame = CGRectMake(slideX, slideY, slideW, slideH);
}

#pragma mark -  延迟加载
- (YHMusicPlayer *)musicPlayer
{
    if (!_musicPlayer) {
        NSString *localPath = [[NSBundle mainBundle] pathForResource:@"one.mp3" ofType:nil];
        NSURL *localUrl = [NSURL fileURLWithPath:localPath];
        _musicPlayer = [YHMusicPlayer playerWihtLocalMusicUrl:localUrl
                                      playerScaleChangedBlock:^(CGFloat scale) {
                                          NSLog(@"进度： %f", scale);
                                          self.slider.value = scale;
                                      }
                                  playerDidFinishPlayingBlock:^{
                                      NSLog(@"已经播放完毕了");
                                  }];
    }
    
    return _musicPlayer;
}

/** 播放／暂停按钮 */
- (UIButton *)playPauseBtn
{
    if (!_playPauseBtn) {
        UIButton *playPauseBtn = [[UIButton alloc] init];
        [self.controlBackView addSubview:playPauseBtn];
        _playPauseBtn = playPauseBtn;
        
        [playPauseBtn setTitle:@"播放" forState:UIControlStateNormal];
        [playPauseBtn setTitle:@"暂停" forState:UIControlStateSelected];
        
        [playPauseBtn addTarget:self action:@selector(playPauseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playPauseBtn;
}

/** 停止按钮 */
- (UIButton *)stopBtn
{
    if (!_stopBtn) {
        UIButton *stopBtn = [[UIButton alloc] init];
        [self.controlBackView addSubview:stopBtn];
        _stopBtn = stopBtn;
        
        [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        
        [stopBtn addTarget:self action:@selector(stopBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _stopBtn;
}

/** 进度条 */
- (UISlider *)slider
{
    if (!_slider) {
        UISlider *slider = [[UISlider alloc] init];
        [self.controlBackView addSubview:slider];
        _slider = slider;
    }
    
    return _slider;
}

/** 播放器控制条背景 */
- (UIView *)controlBackView
{
    if (!_controlBackView) {
        UIView *controlBackView = [[UIView alloc] init];
        [self.view addSubview:controlBackView];
        _controlBackView = controlBackView;
        
        controlBackView.backgroundColor = [UIColor grayColor];
        
    }
    return _controlBackView;
}

#pragma mark - 事件处理
- (void)playPauseBtnClicked
{
    if (!self.playPauseBtn.selected) {
        [self.musicPlayer play];
    } else {
        [self.musicPlayer pause];
    }
    
    self.playPauseBtn.selected = !self.playPauseBtn.selected;
}

- (void)stopBtnClicked
{
    [self.musicPlayer stop];
}

@end
