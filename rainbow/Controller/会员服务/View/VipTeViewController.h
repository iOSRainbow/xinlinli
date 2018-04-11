//
//  VipTeViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipTeViewController : CommonViewController{
 
    UIScrollView * scr;

    UILabel * levelLb,*vipInfoLb;
}

@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,strong)NSString * Amount;
@end
