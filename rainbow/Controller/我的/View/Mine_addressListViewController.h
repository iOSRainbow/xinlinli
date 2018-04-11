//
//  Mine_addressListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_addressListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray * dataArray;
    UITableView * tableview;
    NSInteger cellTag;

}

@property(nonatomic,strong)NSString * fromView;
@end
