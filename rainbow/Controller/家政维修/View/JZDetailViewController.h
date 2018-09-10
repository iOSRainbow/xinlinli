//
//  JZDetailViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface JZDetailViewController : CommonViewController
{
    UIScrollView * scr;
    NSDictionary * itemDic;
    UILabel * priceLable;
    NSArray * goodsinfos;
    NSArray * picArray;
    UILabel * GoodsName;
    NSString * idStr;
    NSInteger goodNum;

}

@property(nonatomic,strong)NSString* goodsId;


@end
