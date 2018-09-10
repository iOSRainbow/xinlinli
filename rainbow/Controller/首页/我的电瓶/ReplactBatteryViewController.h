//
//  ReplactBatteryViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/9/5.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplactBatteryViewController : CommonViewController
{

    UILabel * labBatteryPrice;
    UILabel * labCountPrice;
    UIButton * btnDiscount;
    NSString * rent,*deposit,*installation;
    NSInteger countPrice;
    
}

@property(nonatomic,strong)NSString * number,*year;
@end
