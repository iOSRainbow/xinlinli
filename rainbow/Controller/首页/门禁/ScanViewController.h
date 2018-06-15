//
//  ScanViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/25.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KddSocket.h"

@interface ScanViewController : CommonViewController<AVCaptureMetadataOutputObjectsDelegate,SocketDelegate>
{
    
    AVCaptureSession * seccion;
    CAGradientLayer * scanLayer;
    UIView *scanBox;
    
    NSTimer * timer;
    
    CGFloat space;
    CGFloat imageW;
    CGFloat imageY;
    UIImageView * lineView;
    BOOL isUp;
    NSInteger num;
    UILabel * infoLable;
    
  
}
@property (nonatomic,copy)  void(^completeBlockNSString)(NSString *completeStr);

@property(nonatomic,assign)NSInteger type;
@end
