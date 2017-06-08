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
    CGFloat playW = self.view.frame.size.width - 3 * playX;
    CGFloat playH = 40;
    self.playSoundBtn.frame = CGRectMake(playX, playY, playW, playH);
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


#pragma mark - 点击按钮的响应
- (void)playSoundBtnClicked
{
    NSLog(@"即将播放");
    [YHAudioPlayer playShortSoundWithSoundFileName:@"in.caf"];
}

@end
