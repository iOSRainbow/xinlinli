//
//  ScanViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/25.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ScanViewController : ZBarReaderViewController<UIImagePickerControllerDelegate,ZBarReaderDelegate>
{
    UIView * navView;
    
    NSInteger num;
    NSTimer *timer;
    BOOL isUp;
    
    //扫描时上下移动的线条
    UIImageView *mainImage;
    CGFloat space;
    CGFloat imageW;
    CGFloat imageY;
    
    UILabel *infoLable,*lineLb;
}
@property (nonatomic,copy)  void(^completeBlockNSString)(NSString *completeStr);

@end
