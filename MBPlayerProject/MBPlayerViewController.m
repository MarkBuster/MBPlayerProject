//
//  MBPlayerViewController.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/15.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "MBPlayerViewController.h"

@interface MBPlayerViewController ()

@property (nonatomic, assign) CGRect tempRect;

@end

@implementation MBPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blackColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.videoPreviewBlock) {
        self.videoPreviewBlock();
    }
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"2");
    }];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 270)];
        [self.view addSubview:_topView];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (void)setPreview:(UIView *)preview {
    _tempRect = preview.frame;
    _preview = preview;
    _preview.frame = _preview.bounds;
     [self.view addSubview:self.preview];
}

- (void)dealloc {
    NSLog(@"销毁");
}
@end
