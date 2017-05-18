//
//  ijkPlayerManager.h
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/17.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ijkPlayerManager : NSObject


+ (instancetype)shareInstancetype ;

- (void)configContentURLString:(NSString *)url;
- (UIView *)view ;
@end
