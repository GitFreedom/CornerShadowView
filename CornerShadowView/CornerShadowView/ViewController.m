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
    [self addDemoViews];
}
- (void)addDemoViews {
    //创建view
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor blueColor];
    //创建label
    UILabel *label        = [UILabel new];
    label.text            = @"Freedom";
    label.font            = [UIFont systemFontOfSize:16.0f];
    label.textColor       = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    //创建button
    UIButton *button      = [UIButton new];
    [button setImage:[UIImage imageNamed:@"temp"] forState:UIControlStateNormal];
    //创建imageView
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp"]];
    
    NSArray *classNameArray   = @[view,label,button,imageView];
    CGFloat statusBarHeight   = CGRectGetHeight([UIScreen mainScreen].bounds) >= 812.0f ? 44.0f : 20.0f;
    CGFloat navigationHeight  = statusBarHeight + 44.0f;
    CGFloat defaultViewHeight = 66.0f;
    CGFloat defaultMargin     = 10.0f;
    CGFloat viewMargin        = (CGRectGetWidth(self.view.frame) - defaultViewHeight*2)/3.0;
    for (NSInteger i = 0; i < classNameArray.count; i++) {
        UIView *view = classNameArray[i];
        view.frame   = CGRectMake(viewMargin + (defaultViewHeight + viewMargin)*(i%2), navigationHeight + (defaultViewHeight + defaultMargin * 2) * (i/2), defaultViewHeight, defaultViewHeight);
        [self.view addSubview:view];
        WJDCornerShadowView *cornShadowView = [[WJDCornerShadowView alloc]initWithFrame:CGRectMake(CGRectGetMinX(view.frame) - defaultMargin, CGRectGetMinY(view.frame) - defaultMargin, CGRectGetWidth(view.frame) + defaultMargin*2, CGRectGetHeight(view.frame) + defaultMargin*2)];
        cornShadowView.bgColor              = self.view.backgroundColor;
        //这里设置0.6只是为了让阴影更明显，可以根据自己的需求调
        cornShadowView.shadowColor          = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        cornShadowView.shadowBlur           = 10.0f;
        [self.view addSubview:cornShadowView];
    }
}

@end
