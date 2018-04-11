//
//  ScanCropView.m
//  E_Express
//
//  Created by GuiDaYou on 15/10/8.
//  Copyright (c) 2015年 dayo. All rights reserved.
//

#import "ScanCropView.h"

@implementation ScanCropView

- (void)drawRect:(CGRect)rect {
    CGFloat space=60;
    
    CGFloat imageW=SCREEN_WIDTH-space*2;
    CGFloat imageY=(SCREEN_HEIGHT-imageW)/2-50;
    //获得图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置切除的rect区域
    CGRect cropRect=CGRectMake(space, imageY, imageW, imageW);
    CGContextClipToRect(context, cropRect);
    CGContextClearRect(context, cropRect);
    //设置整个图形为clearColor
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    

}

@end
