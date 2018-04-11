//
//  VipViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipViewController : CommonViewController
{
  
    UIScrollView *scr;
    UIImageView * headImg;
    UILabel * nickname,*statusLb;
    NSMutableArray*gouArray,*dataArray,*moenyArray;
    UIView * Vipview,*VipTaoCanView,*VipCardView;
    CGFloat balance,amount;
    UIButton * surePaybtn;
    NSInteger Tag;
    NSString * addition;
    

}
@end
