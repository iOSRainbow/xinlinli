//
//  WXTipDetailViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WuYeTipModel.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface WXTipDetailViewController : CommonViewController{

    UILabel* titleLb;
    UIScrollView * scr;
}
@property(nonatomic,strong)WuYeTipModel* model;

@end
