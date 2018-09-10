//
//  GoodTypeViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/2/26.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeletedGoodsModel.h"
#import "SeletedGoodsCell.h"

@interface GoodTypeViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * tableview;
    NSMutableArray * dataArray;
    
}
@property(nonatomic,strong)NSMutableArray * array;

@property (nonatomic,copy)  void(^completeBlock)(SeletedGoodsModel *model);

@end
