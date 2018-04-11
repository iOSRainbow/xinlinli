//
//  BusLockViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusLockViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableview;
    NSMutableArray * dataArray;
    

}
@end
