//
//  MBLiveViewController.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/18.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "MBLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "VolumeBrightnessView.h"
#import <VideoToolbox/VideoToolbox.h>

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface MBLiveViewController ()<
IJKMediaUrlOpenDelegate,
VolumeBrightnessDelegate
>

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@property (nonatomic, strong) IJKMPMoviePlayerController *movePlayer;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *tempView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *fullScreenBtn;

@property (nonatomic, strong) VolumeBrightnessView *volumeBrightView;

@end

@implementation MBLiveViewController

- (void)viewDidDisappear:(BOOL)animated {
    [_player shutdown]; // 不写这句 控制器不会被释放  _player一只在运行
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:[self configPlayer:[self liveURL] insertTo:self.topView]];
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    [self installMovieNotificationObservers];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"<" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn setFrame:CGRectMake(0, 0, 50, 50)];
    [backBtn setTag:1];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
   
    

    [self.view addSubview:self.pauseBtn];
    [self.view addSubview:self.fullScreenBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiverNotification)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 270)];
        _topView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.topView];
    }
    return _topView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 135);
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (VolumeBrightnessView *)volumeBrightView {
    if (!_volumeBrightView) {
        _volumeBrightView = [[VolumeBrightnessView alloc] init];
        _volumeBrightView.delegate = self;
        _volumeBrightView.hidden = YES;
        [self.tempView addSubview:_volumeBrightView];
    }
    return _volumeBrightView;
}

- (UIButton *)pauseBtn {
    if (!_pauseBtn) {
        _pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseBtn setTitle:@"||" forState:UIControlStateNormal];
        [_pauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
        [_pauseBtn setTag:2];
        [_pauseBtn setFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 45, 150, 50, 50)];
    }
    return _pauseBtn;
}

- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setTitle:@"X" forState:UIControlStateNormal];
        [_fullScreenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fullScreenBtn setTag:3];
        [_fullScreenBtn setFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 45, 200, 50, 50)];
        [_fullScreenBtn addTarget:self action:@selector(fullScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pause {
    if ([_player isPlaying]) {
        [_player pause];
    }else {
        [_player play];
    }
}

- (void)fullScreen:(UIButton *)btn {
    btn.selected =!btn.selected;
    if (btn.selected) {
        NSLog(@"全屏");
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
     }else {
        NSLog(@"半屏");
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
    }
}

- (void)orientationChange:(BOOL)landscapeRight {
    if (landscapeRight) {
        NSLog(@"%@", NSStringFromCGRect(self.view.frame));
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//            self.topView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
//            self.pauseBtn.frame = CGRectMake(CGRectGetHeight(self.view.frame) -45, CGRectGetWidth(self.view.frame) - 160, 50, 50);
//            self.fullScreenBtn.frame = CGRectMake(CGRectGetHeight(self.view.frame) - 45, CGRectGetWidth(self.view.frame) - 60, 50, 50);
//            self.topView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
//            self.tempView.frame = self.topView.bounds;
            self.indicatorView.center = CGPointMake(CGRectGetHeight(self.view.frame)/2, CGRectGetWidth(self.view.frame)/2);
//            self.volumeBrightView.hidden =NO;
 
        }];
    } else {
        NSLog(@"%@", NSStringFromCGRect(self.view.frame));
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//            self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270);
//            self.pauseBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 45, 150, 50, 50);
//            self.fullScreenBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 45, 200, 50, 50);
//            self.topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 270);
//            self.tempView.frame = self.topView.bounds;
            self.indicatorView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 135);
//            self.volumeBrightView.hidden =YES;
        }];
    }
}

- (UIView *)configPlayer:(NSString *) url insertTo:(UIView *) Pview{
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:nil];
    _player.shouldAutoplay = YES;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [_player prepareToPlay];
    _player.liveOpenDelegate = self;
 
    _tempView.backgroundColor = [UIColor whiteColor];
    if (Pview) {
        _tempView = [_player view];
        _tempView.frame = Pview.bounds;
        return _tempView;
    }else {
        return [_player view];
    }
}

- (NSString *)liveURL {
//    https://vod2.fangyan.tv/c07a0ccbd55e47dc.mp4
    return @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
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
    
    // 播放状态改变时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];

}

#pragma mark - VolumeBrightnessDelegate
- (void)volumeBrightnessView:(VolumeBrightnessView *)view panType:(VolumeBrightnessType)type value:(CGFloat)value {
    
}


#pragma mark - aa 
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
}

#pragma mark - not
- (void)receiverNotification {
    NSLog(@"旋转了");
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
            [self.indicatorView startAnimating];
//            _player.fpsAtOutput
//            _player.fpsInMeta
            NSLog(@"");
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
        case IJKMPMoviePlaybackStateStopped:{
            NSLog(@"播放状态变化 %d: stoped", (int)_player.playbackState);
        }
            break;
            
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"开始 %d: playing", (int)_player.playbackState);
            [self.indicatorView stopAnimating];
        }
            break;
            
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"暂停 %d: paused", (int)_player.playbackState);
        }
            break;
            
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"打断 %d: interrupted", (int)_player.playbackState);
        }
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
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

#pragma mark -
- (void)willOpenUrl:(IJKMediaUrlOpenData*) urlOpenData {
    NSLog(@"%d -- %@ -- %@", urlOpenData.fd,urlOpenData.msg,urlOpenData.url);
}


#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
    [_player pause];
    _player = nil;
    NSLog(@"%@ 销毁", [self class]);
}
@end
