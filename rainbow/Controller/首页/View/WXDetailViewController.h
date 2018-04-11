//
//  WXDetailViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXDetailViewController : CommonViewController
{

    UIScrollView * scr;
    NSDictionary * itemDic;
}

@property(nonatomic,strong)NSString *wxId;
@end
