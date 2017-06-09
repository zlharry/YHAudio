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
@end

@implementation PlayLocalMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本地音乐播放器";
    
    NSString *localPath = [[NSBundle mainBundle] pathForResource:@"one.mp3" ofType:nil];
    NSURL *localUrl = [NSURL fileURLWithPath:localPath];
    YHMusicPlayer *player = [YHMusicPlayer playerWihtLocalMusicUrl:localUrl
                                           playerScaleChangedBlock:^(CGFloat scale) {
                                               NSLog(@"进度： %f", scale);
                                           }
                                       playerDidFinishPlayingBlock:^{
                                           NSLog(@"已经播放完毕了");
                                       }];
    self.musicPlayer = player;
    [player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *localPath = [[NSBundle mainBundle] pathForResource:@"one.mp3" ofType:nil];
    NSURL *localUrl = [NSURL fileURLWithPath:localPath];
    self.musicPlayer.localMusicUrl = localUrl;
    [self.musicPlayer stop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
