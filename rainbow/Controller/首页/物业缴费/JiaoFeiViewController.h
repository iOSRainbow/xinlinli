//
//  JiaoFeiViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/23.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiaoFeiViewController : CommonViewController{

    UIScrollView * scr;
    UILabel * addressLb,*nameLb,*cityLb,*tipLb,*payLb,*moneyLb;
    UITextField * numText,*monthText;
    NSString * addressId,*bulidingId,*cellId;
    double countPay,priceDouble;

}

@end
