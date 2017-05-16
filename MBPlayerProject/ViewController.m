//
//  ViewController.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/15.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "ViewController.h"
#import "MBPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "IJKMoviePlayerViewController.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIView *preview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.indicatorView startAnimating];
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"my_video" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:path];
    
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear2/prog_index.m3u8"]] withOptions:nil];
    _player.shouldAutoplay = YES;
    UIView *playerView = [_player view];
    playerView.frame = self.preview.bounds;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.preview insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [self installMovieNotificationObservers];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.preview addGestureRecognizer:tap];
    
//    IJKMoviePlayerViewController *vc = [[IJKMoviePlayerViewController alloc] init];
//    vc.url = @"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear2/prog_index.m3u8";
//    vc.view.frame = self.preview.bounds;
//    [self.preview addSubview:vc.view];
    
//    [[MPMoviePlayerController new] requestThumbnailImagesAtTimes:<#(NSArray *)#> timeOption:<#(MPMovieTimeOption)#>]
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnAction:(UIButton *)sender {
    if ([self.player isPlaying]) {
        [self.player pause];
    }else {
        [self.player play];
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    MBPlayerViewController *playerVC = [[MBPlayerViewController alloc] init];
    [self presentViewController:playerVC animated:YES completion:nil];
}



- (void)installMovieNotificationObservers {
    // 网络状态改变时调用
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    // 电影播放结束，或者用户推出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    // 媒体准备播放状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    // 播放状态改变时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
    
//    属性发生改变时调用
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerFirstVideoFrame:)
                                                 name:IJKMPMoviePlayerFirstVideoFrameRenderedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerFirstAudioFrame:)
                                                 name:IJKMPMoviePlayerFirstAudioFrameRenderedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerVideoDecoderOpen:)
                                                 name:IJKMPMoviePlayerVideoDecoderOpenNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerNaturalSizeAvailable:)
                                                 name:IJKMPMovieNaturalSizeAvailableNotification
                                               object:_player];
}

#pragma mark - Selector func
// 网络状态改变 会持续执行
- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
//    _player.currentPlaybackTime
//    _player.duration
//    _player.playableDuration
//    NSLog(@"%f -- %f -- %f",_player.currentPlaybackTime,_player.duration,_player.playableDuration);
//    NSLog(@"bufferingProgress == %ld", (long)_player.bufferingProgress);
    NSLog(@"%@", NSStringFromCGSize(_player.naturalSize));
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

// 视频播放状态变化 会持续执行
- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

// 电影播放完成
- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}


- (void)moviePlayerVideoDecoderOpen:(NSNotification *)noti {
    NSLog(@"视频解码器开始 1");
}

// 播放状态的改变
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"播放状态改变 2");
}

- (void)moviePlayerFirstAudioFrame:(NSNotification *)noti {
    NSLog(@"音频开始播放 3");
}

- (void)moviePlayerFirstVideoFrame:(NSNotification *)noti {
    NSLog(@"视频开始播放 4 -> loadStateDidChange");
}

- (void)moviePlayerNaturalSizeAvailable:(NSNotification *)noti {
    NSLog(@"视频相关属性可用，属性每次调用完后都会执行该方法");
}


#pragma mark - RemoveNoti
- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerFirstVideoFrameRenderedNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerFirstAudioFrameRenderedNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerVideoDecoderOpenNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMovieNaturalSizeAvailableNotification
                                                  object:_player];
}

@end
