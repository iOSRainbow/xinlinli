//
//  MenJinListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/7/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenJinListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataArray;
    UITableView*tableview;

}
@end
