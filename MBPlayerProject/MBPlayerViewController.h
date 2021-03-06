//
//  MBPlayerViewController.h
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/15.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBPlayerViewController : UIViewController


@property (nonatomic, strong) UIView *preview;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, copy) void (^videoPreviewBlock)();
@end
