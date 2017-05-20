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
#import "ijkPlayerManager.h"

#import "MBLocalMovieViewController.h"
#import "MBLiveViewController.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *localPlayBtn;

@property (strong, nonatomic) IBOutlet UIView *preview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@property (nonatomic, strong) IJKMPMoviePlayerController *movePlayer;


@property (nonatomic, assign) CGRect tempRect;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.player isPlaying]) {
        [self.player pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.indicatorView startAnimating];
    
    UIView *view = [self configPlayer:[self localMovieURL] insertTo:self.preview];
    [self.preview insertSubview:view  atIndex:1];
    [self installMovieNotificationObservers];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.preview addGestureRecognizer:tap];

    self.tempRect = self.preview.frame;
    
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoAtion:)];
    tapTwo.numberOfTapsRequired = 2;
    [self.preview addGestureRecognizer:tapTwo];
    
    [self.player prepareToPlay];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)removePreviewSubViews {
    if (self.preview.subviews.count >0) {
        for (NSInteger i = self.preview.subviews.count; i>0; i--) {
            id temp = [self.preview.subviews objectAtIndex:i];
            [temp removeFromSuperview];
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
 
    MBLiveViewController *liveVC = [[MBLiveViewController alloc] init];
    [self presentViewController:liveVC animated:YES completion:nil];
}
- (IBAction)playLocalMovie:(UIButton *)sender {
 
    MBLocalMovieViewController *moviceVC = [[MBLocalMovieViewController alloc] init];
    [self presentViewController:moviceVC animated:YES completion:nil];
}

- (UIView *)configPlayer:(NSString *) url insertTo:(UIView *) Pview{
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:nil];
    _player.shouldAutoplay = YES;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [_player prepareToPlay];
    
    UIView *tempView;
    if (Pview) {
        tempView = [_player view];
        tempView.frame = Pview.bounds;
        return tempView;
    }else {
        return [_player view];
    }
}


- (NSString *)localMovieURL {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"my_video" ofType:@"mp4"];
    BOOL isfile = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!isfile)  return @"";
    return path;
}

- (NSString *)liveURL {
    return @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
}



- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([self.player isPlaying]) {
        [self.player pause];
    }else {
        [self.player play];
    }
}

- (void)twoAtion:(UITableViewScrollPosition *)tap {
    MBPlayerViewController *playerVC = [[MBPlayerViewController alloc] init];
    [playerVC.topView addSubview:[_player view]];
    [self presentViewController:playerVC animated:YES completion:nil];
    
    [playerVC setVideoPreviewBlock:^{
        [self.preview addSubview:[self.player view]];
    }];
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
//    NSLog(@"%@", NSStringFromCGSize(_player.naturalSize));
    switch (loadState) {
        case IJKMPMovieLoadStatePlayable:
            NSLog(@"可播放");
            break;
        case IJKMPMovieLoadStatePlaythroughOK:
            NSLog(@"状态为缓冲几乎完成，可以连续播放");
            break;
        case IJKMPMovieLoadStateStalled:
            NSLog(@"缓冲中");
            break;
        case IJKMPMovieLoadStateUnknown:
            NSLog(@"未知状态");
            break;
        default:
            break;
    }
}

// 视频播放状态变化 会持续执行
- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"播放状态变化 %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"开始 %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"暂停 %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"打断 %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"快进／快退 %d: seeking", (int)_player.playbackState);
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
    int errorCode = [[[notification userInfo] valueForKey:@"error"] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放结束: %d\n", reason);
            [_player play];
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"播放退出: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"播放出错: %d\n", reason);
            if (errorCode == 19) {
                NSLog(@"硬解失败");
            }
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
