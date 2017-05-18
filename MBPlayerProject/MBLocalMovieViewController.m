//
//  MBLocalMovieViewController.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/18.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "MBLocalMovieViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface MBLocalMovieViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@property (nonatomic, strong) IJKMPMoviePlayerController *movePlayer;
@end

@implementation MBLocalMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
 
    [self.view addSubview:[self configPlayer:[self localMovieURL] insertTo:self.view]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)configPlayer:(NSString *) url insertTo:(UIView *) Pview{
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:nil];
    _player.shouldAutoplay = YES;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [_player prepareToPlay];
    
    UIView *tempView;
    if (Pview) {
        tempView = [_player view];
        tempView.frame = CGRectMake(0, 0, CGRectGetHeight(Pview.frame), CGRectGetWidth(Pview.frame));
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

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
@end
