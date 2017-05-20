//
//  VolumeBrightnessView.h
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/19.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    VolumeBrightnessTypeVolume,
    VolumeBrightnessTypeBrightness,
} VolumeBrightnessType;

@class VolumeBrightnessView;
@protocol VolumeBrightnessDelegate <NSObject>

- (void)volumeBrightnessView:(VolumeBrightnessView *)view panType:(VolumeBrightnessType )type  value:(CGFloat)value;

@end

@interface VolumeBrightnessView : UIView

@property (nonatomic, weak) id <VolumeBrightnessDelegate>delegate;
@end
