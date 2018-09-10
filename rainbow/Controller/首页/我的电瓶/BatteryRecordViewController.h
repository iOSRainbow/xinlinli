//
//  BatteryRecordViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/9/5.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BatteryRecordViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * dataArray;
    UITableView * tableview;
}

@end
