//
//  ViewController.m
//  CornerShadowView
//
//  Created by 王俊东 on 2018/10/23.
//  Copyright © 2018年 www.wangjundong.com. All rights reserved.
//

#import "ViewController.h"
#import "WJDCornerShadowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultDemo];
}

- (void)defaultDemo {
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewY     = (CGRectGetHeight(self.view.frame) - viewWidth)*0.5;
    WJDCornerShadowView *cornerShadowView = [[WJDCornerShadowView alloc]initWithFrame:CGRectMake(0, viewY, viewWidth, viewWidth)];
    [self.view addSubview:cornerShadowView];
}

@end
