//
//  WuYeTipViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WuYeTipModel.h"
#import "WuYeTipCell.h"


@interface WuYeTipViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray * dataArray;
    UITableView*tableview;

}

@end
