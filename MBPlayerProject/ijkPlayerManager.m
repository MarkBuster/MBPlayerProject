//
//  ijkPlayerManager.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/17.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "ijkPlayerManager.h"
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface ijkPlayerManager()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@end


static ijkPlayerManager *manager;
@implementation ijkPlayerManager


+ (instancetype)shareInstancetype {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ijkPlayerManager alloc] init];
    });
    return manager;
}


- (void)configContentURLString:(NSString *)url {
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:nil];
    _player.shouldAutoplay = YES;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
}

- (UIView *)view {
    return [_player view];
}
@end
