//
//  WJDCornerShadowView.m
//  CornerShadowView
//
//  Created by 王俊东 on 2018/10/23.
//  Copyright © 2018年 www.wangjundong.com. All rights reserved.
//

#import "WJDCornerShadowView.h"

@implementation WJDCornerShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentInsets   = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        self.radius          = 8.0f;
        self.bgColor         = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.showShadow      = YES;
        self.shadowColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.03];
        self.shadowOffset    = CGSizeZero;
        self.shadowBlur      = 6.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    if (contextRef == NULL) {
        return;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.contentInsets)) {
        [self drawEdgeInsetsZeroRect:rect ContextRef:contextRef];
    }
    else {
        CGFloat width        = rect.size.width;
        CGFloat height       = rect.size.height;
        CGFloat topMargin    = self.contentInsets.top;
        CGFloat leftMargin   = self.contentInsets.left;
        CGFloat bottomMargin = self.contentInsets.bottom;
        CGFloat rightMargin  = self.contentInsets.right;
        //step1 创建上半部分路径
        CGMutablePathRef topPath = CGPathCreateMutable();
        CGPathMoveToPoint(topPath, NULL, 0, 0);
        CGPathAddLineToPoint(topPath, NULL, width, 0);
        CGPathAddLineToPoint(topPath, NULL, width, height*0.5);
        CGPathAddLineToPoint(topPath, NULL, width - rightMargin, height*0.5);
        CGPathAddLineToPoint(topPath, NULL, width - rightMargin, topMargin + self.radius);
        CGPathAddArc(topPath, NULL, width - rightMargin - self.radius, topMargin + self.radius, self.radius, 0, -M_PI*0.5, 1);
        CGPathAddLineToPoint(topPath, NULL, leftMargin + self.radius, topMargin);
        CGPathAddArc(topPath, NULL, leftMargin + self.radius, topMargin + self.radius, self.radius, -M_PI*0.5, -M_PI, 1);
        CGPathAddLineToPoint(topPath, NULL, leftMargin, height*0.5);
        CGPathAddLineToPoint(topPath, NULL, 0, height*0.5);
        CGPathAddLineToPoint(topPath, NULL, 0, 0);
        //step2 创建下半部分路径
        CGMutablePathRef bottomPath = CGPathCreateMutable();
        CGPathMoveToPoint(bottomPath, NULL, 0, height*0.5);
        CGPathAddLineToPoint(bottomPath, NULL, 0, height);
        CGPathAddLineToPoint(bottomPath, NULL, width, height);
        CGPathAddLineToPoint(bottomPath, NULL, width, height*0.5);
        CGPathAddLineToPoint(bottomPath, NULL, width - rightMargin, height*0.5);
        CGPathAddLineToPoint(bottomPath, NULL, width - rightMargin, height - bottomMargin - self.radius);
        CGPathAddArc(bottomPath, NULL, width - rightMargin - self.radius, height - bottomMargin - self.radius, self.radius, 0, M_PI*0.5, 0);
        CGPathAddLineToPoint(bottomPath, NULL, leftMargin + self.radius, height - bottomMargin);
        CGPathAddArc(bottomPath, NULL, leftMargin + self.radius, height - bottomMargin - self.radius, self.radius, M_PI*0.5, M_PI, 0);
        CGPathAddLineToPoint(bottomPath, NULL, leftMargin, height*0.5);
        CGPathAddLineToPoint(bottomPath, NULL, 0, height*0.5);
        //step3 将圆角矩形之外的环形区域画出来
        CGContextSaveGState(contextRef);
        [self.bgColor set];
        CGContextAddPath(contextRef, topPath);
        CGContextAddPath(contextRef, bottomPath);
        CGContextFillPath(contextRef);
        CGContextRestoreGState(contextRef);
        if (self.showShadow) {
            //step4 创建圆角矩形路径
            CGMutablePathRef roundRectPath = CGPathCreateMutable();
            CGPathMoveToPoint(roundRectPath, NULL, leftMargin, topMargin + self.radius);
            CGPathAddArc(roundRectPath, NULL, leftMargin + self.radius, topMargin + self.radius, self.radius, M_PI, M_PI*1.5, 0);
            CGPathAddLineToPoint(roundRectPath, NULL, width - rightMargin - self.radius, topMargin);
            CGPathAddArc(roundRectPath, NULL, width - rightMargin - self.radius, topMargin + self.radius, self.radius, -M_PI*0.5, 0, 0);
            CGPathAddLineToPoint(roundRectPath, NULL, width - rightMargin, height - bottomMargin - self.radius);
            CGPathAddArc(roundRectPath, NULL, width - rightMargin - self.radius, height - bottomMargin - self.radius, self.radius, 0, M_PI*0.5, 0);
            CGPathAddLineToPoint(roundRectPath, NULL, leftMargin + self.radius, height - bottomMargin);
            CGPathAddArc(roundRectPath, NULL, leftMargin + self.radius, height - bottomMargin - self.radius, self.radius, M_PI*0.5, M_PI, 0);
            CGPathAddLineToPoint(roundRectPath, NULL, leftMargin, topMargin + self.radius);
            //step5 绘制上半部分阴影
            CGContextSaveGState(contextRef);
            [self.bgColor set];
            CGContextAddPath(contextRef, topPath);
            CGContextClip(contextRef);
            CGContextAddPath(contextRef, roundRectPath);
            CGContextSetShadowWithColor(contextRef, self.shadowOffset, self.shadowBlur, self.shadowColor.CGColor);
            CGContextFillPath(contextRef);
            CGContextRestoreGState(contextRef);
            //step6 绘制下半部分阴影
            CGContextSaveGState(contextRef);
            [self.bgColor set];
            CGContextAddPath(contextRef, bottomPath);
            CGContextClip(contextRef);
            CGContextAddPath(contextRef, roundRectPath);
            CGContextSetShadowWithColor(contextRef, self.shadowOffset, self.shadowBlur, self.shadowColor.CGColor);
            CGContextFillPath(contextRef);
            CGContextRestoreGState(contextRef);
            //释放路径
            CGPathRelease(roundRectPath);
        }
        //step8 释放路径
        CGPathRelease(topPath);
        CGPathRelease(bottomPath);
    }
    
}
- (void)drawEdgeInsetsZeroRect:(CGRect)rect ContextRef:(CGContextRef)contextRef {
    
    CGFloat width  = rect.size.width;
    CGFloat height = rect.size.height;
    //step1 创建左上角路径
    CGMutablePathRef topLeftPath = CGPathCreateMutable();
    CGPathMoveToPoint(topLeftPath, NULL, 0, 0);
    CGPathAddLineToPoint(topLeftPath, NULL, self.radius, 0);
    CGPathAddArc(topLeftPath, NULL, self.radius, self.radius, self.radius, -M_PI_2, -M_PI, 1);
    CGPathAddLineToPoint(topLeftPath, NULL, 0, 0);
    //setp2 创建左下角路径
    const CGAffineTransform transform = CGAffineTransformMakeTranslation(0,height);
    const CGAffineTransform transform1 = CGAffineTransformRotate(transform, M_PI*1.5);
    CGMutablePathRef bottomLeftPath = CGPathCreateMutableCopyByTransformingPath(topLeftPath, &transform1);
    //setp3 创建右上角路径
    const CGAffineTransform transform2 = CGAffineTransformMakeTranslation(width,0);
    const CGAffineTransform transform3 = CGAffineTransformRotate(transform2, M_PI_2);
    CGMutablePathRef topRightPath = CGPathCreateMutableCopyByTransformingPath(topLeftPath, &transform3);
    //setp4 创建右下角路径
    const CGAffineTransform transform4 = CGAffineTransformMakeTranslation(width,height);
    const CGAffineTransform transform5 = CGAffineTransformRotate(transform4, M_PI);
    CGMutablePathRef bottomRightPath = CGPathCreateMutableCopyByTransformingPath(topLeftPath, &transform5);
    //seto5 绘制
    [self.bgColor set];
    CGContextAddPath(contextRef, topLeftPath);
    CGContextAddPath(contextRef, bottomLeftPath);
    CGContextAddPath(contextRef, topRightPath);
    CGContextAddPath(contextRef, bottomRightPath);
    CGContextFillPath(contextRef);
    //step6 释放路径
    CGPathRelease(topLeftPath);
    CGPathRelease(bottomLeftPath);
    CGPathRelease(topRightPath);
    CGPathRelease(bottomRightPath);
}

@end
