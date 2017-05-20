//
//  VolumeBrightnessView.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/19.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "VolumeBrightnessView.h"
#import <MediaPlayer/MediaPlayer.h>
//#import <AVFoundation/AVFoundation.h>

@interface VolumeBrightnessView ()
@property (nonatomic, strong) MPVolumeView *mpVolumeView;
@property (nonatomic, strong) UISlider *mpVolumeSlider;
@end

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation VolumeBrightnessView {
    CGFloat _tempY;
    BOOL _isVolum;
}

- (instancetype)init {
    if (self = [super init]) {
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        self.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        self.backgroundColor = [UIColor clearColor];
        
        if (!_mpVolumeView) {
            if (_mpVolumeView == nil) {
                _mpVolumeView = [[MPVolumeView alloc] init];
                
                for (UIView *view in [_mpVolumeView subviews]) {
                    if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
                        _mpVolumeSlider = (UISlider *)view;
                        break;
                    }
                }
                [_mpVolumeView setFrame:CGRectMake(-100, -100, 40, 40)];
                [_mpVolumeView setShowsVolumeSlider:YES];
                [_mpVolumeView sizeToFit];
            }
        }
    }
    return self;
}



- (void)pan:(UIPanGestureRecognizer *)gest {
    CGPoint point = [gest locationInView:self];
//    NSLog(@"point == %@", NSStringFromCGPoint(point));
//    CGPoint locationPoint = [gest locationInView:gest.view]; //根据在view上Pan的位置，确定是调音量还是亮度
//    CGPoint veloctyPoint = [gest velocityInView:gest.view]; // 根据上次和本次移动的位置，算出一个速率的point
    
    CGPoint velocity = [gest velocityInView:gest.view];
    CGFloat ratio = 13000.f;
    
    CGFloat nowVolumeValue = _mpVolumeSlider.value;
    float changeValue = (nowVolumeValue - velocity.y / ratio);
    [_mpVolumeView setHidden:YES];
    [_mpVolumeSlider setValue:changeValue animated:YES];
    [_mpVolumeSlider sendActionsForControlEvents:UIControlEventAllEvents];
    
    switch (gest.state) {
        case UIGestureRecognizerStateBegan:{
             _isVolum = point.x > self.frame.size.width/2;
            if (_isVolum) {
//                NSLog(@"音量");
            }else {
//                NSLog(@"亮度");
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self commitTranslation:point];
            break;
        case UIGestureRecognizerStateEnded:
            _tempY = 0;
            break;
        default:
            break;
    }
}

- (void)commitTranslation:(CGPoint)translation {
    if (_tempY > translation.y) {
        if (_isVolum) {
//            NSLog(@"音量 ++");
        }else {
//            NSLog(@"亮度 ++");
        }
    }else {
        if (_isVolum) {
//            NSLog(@"音量 --");
        }else {
//            NSLog(@"亮度 --");
        }
    }
    _tempY = translation.y;

}
@end
