//
//  MBPlayerViewController.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/15.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import "MBPlayerViewController.h"

@interface MBPlayerViewController ()

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
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
