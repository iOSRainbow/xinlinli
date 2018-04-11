//
//  DiscountListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/7/28.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHModel.h"
@interface DiscountListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView * tableview;
    NSMutableArray * dataArray;
    
    
}

@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSMutableArray * array1;
@property(nonatomic,strong)NSMutableArray * array2;

@property (nonatomic,copy)  void(^completeBlockModel)(DHModel *model);

@end
