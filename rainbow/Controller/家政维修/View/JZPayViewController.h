//
//  JZPayViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZPayViewController : CommonViewController
{
    UIScrollView * scr;
    
    UILabel * tipLable,*nameLable,*addressLable,*priceInfoLable,*discountLable;
    
    UITextField * text;
    
    NSString * addressName,*addressTel;
    
    UIImageView * selectImg,*unselectImg;
    
    NSInteger payType,deposit;
    
    CGFloat discount,offsetcount,countPrice,price;
    
    UILabel * shopName,*shopPrice,*shopGoodName;
    UIImageView * shopPicImg;
    NSArray * redeemcells,*voucherCustoms;
    NSString*vouchercellId;
    NSString*voucherId;
    NSString*subprice;
    NSString * goodspacatid;
    
}
@property(nonatomic,strong)NSString * IdStr;
@property(nonatomic,assign)NSInteger goodNum;


@end
