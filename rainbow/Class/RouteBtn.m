//
//  RouteBtn.m
//  deyingSoft
//
//  Created by 李世飞 on 17/9/8.
//  Copyright © 2017年 世飞-大有. All rights reserved.
//

#import "RouteBtn.h"

@implementation RouteBtn


// 文字的高度比例
static const CGFloat kTitleRatio = 0.4;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //2.设置文字大小和颜色
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self setTitleColor:white forState:UIControlStateNormal];
        //3.设置图片居中
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

#pragma mark - 覆盖父类的方法
- (void)setHighlighted:(BOOL)highlighted{}


#pragma mark - 设置图片和文字居中
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = contentRect.size.height*0.1;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * (1 - kTitleRatio) - imageY;
   
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleH;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
