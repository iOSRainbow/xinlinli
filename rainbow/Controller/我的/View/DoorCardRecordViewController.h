//
//  DoorCardRecordViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/5/11.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoorCardRecordViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView * tableView;
    NSMutableArray * dataArray;
    NSInteger cellTag;
}

@end
