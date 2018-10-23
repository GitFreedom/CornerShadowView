//
//  WJDCornerShadowView.h
//  CornerShadowView
//
//  Created by 王俊东 on 2018/10/23.
//  Copyright © 2018年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDCornerShadowView : UIView

/**
 *  边距 （默认是UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)）
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;
/**
 *  圆角半径 （默认是8.0f）
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  背景色 （默认是[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]）
 */
@property (nonatomic, strong) UIColor *bgColor;
/**
 *  是否显示阴影 （默认是YES）
 */
@property (nonatomic, assign) BOOL    showShadow;
/**
 *  阴影颜色 （默认是[UIColor colorWithRed:0 green:0 blue:0 alpha:0.03]）
 */
@property (nonatomic, strong) UIColor *shadowColor;
/**
 *  阴影偏移量 （默认是CGSizeZero）
 */
@property (nonatomic, assign) CGSize  shadowOffset;
/**
 *  模糊度 （默认是6.0f）
 */
@property (nonatomic, assign) CGFloat shadowBlur;

@end

NS_ASSUME_NONNULL_END
