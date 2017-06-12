//
//  PlayShortSoundVC.m
//  YHAudio
//
//  Created by harry on 2017/6/8.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "PlayShortSoundVC.h"
#import "YHAudioPlayer.h"

@interface PlayShortSoundVC ()

/** 点击播放短音频的按钮 */
@property (nonatomic, weak) UIButton *playSoundBtn;
/** 点击播放短音频的按钮(带震动) */
@property (nonatomic, weak) UIButton *playAlertSoundBtn;

@end

@implementation PlayShortSoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"播放短音频";
    
    [self setupBtnFrames];
}

#pragma mark - 私有方法
- (void)setupBtnFrames
{
    CGFloat playX = 10;
    CGFloat playY = 80;
    CGFloat playW = self.view.frame.size.width - 1 * playX;
    CGFloat playH = 40;
    self.playSoundBtn.frame = CGRectMake(playX, playY, playW, playH);
    
    CGFloat playAlerX = playX;
    CGFloat playAlerY = playY + playH + 10;
    CGFloat playAlerW = playW;
    CGFloat playAlerH = playH;
    self.playAlertSoundBtn.frame = CGRectMake(playAlerX, playAlerY, playAlerW, playAlerH);
}

#pragma mark - 延迟加载
/** 点击播放短音频的按钮 */
- (UIButton *)playSoundBtn
{
    if (!_playSoundBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        _playSoundBtn = btn;
        
        [btn setTitle:@"播放提示音" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 2;
        
        [btn addTarget:self action:@selector(playSoundBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _playSoundBtn;
}

/** 点击播放短音频的按钮(带震动) */
- (UIButton *)playAlertSoundBtn
{
    if (!_playAlertSoundBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        _playAlertSoundBtn = btn;
        
        [btn setTitle:@"播放提示音(同时手机震动)" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 2;
        
        [btn addTarget:self action:@selector(playAlertSoundBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _playAlertSoundBtn;
}

#pragma mark - 点击按钮的响应
- (void)playSoundBtnClicked
{
    NSLog(@"即将开始播放");
    [YHAudioPlayer playShortSoundWithSoundFileName:@"in.caf" shake:NO finishPlayBlock:^(SystemSoundID soundID) {
        NSLog(@"播放结束了：%d", soundID);
    }];
}

- (void)playAlertSoundBtnClicked
{
    NSLog(@"即将开始播放（震动）");
    [YHAudioPlayer playShortSoundWithSoundFileName:@"in.caf" shake:YES finishPlayBlock:^(SystemSoundID soundID) {
        NSLog(@"播放结束了（震动）：%d", soundID);
    }];
}

@end
