//
//  PayDespositViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/9/4.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayDespositViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableview;
    NSMutableArray * dataArray;
    NSMutableArray * gouArray;

    UILabel * labPrice;
    NSInteger  cellTag;
}
@property(nonatomic,strong)NSString*deposit;

@end
