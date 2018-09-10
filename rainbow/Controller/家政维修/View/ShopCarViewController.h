//
//  ShopCarViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
#import "ShopCarCell.h"

@interface ShopCarViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray * dataArray;
    UITableView * tableview;
    NSInteger cellTag;
    NSIndexPath *chooseIndexPath;
    UIView * bottomView,*complteView;
    UILabel * priceLb;
    UIButton * allBtn;
}
@end
