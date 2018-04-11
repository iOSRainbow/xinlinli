//
//  GuoQiViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuoQiViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableview;
    NSMutableArray * dataArray;
}
@property(nonatomic,strong)NSString*fromView;

@end
