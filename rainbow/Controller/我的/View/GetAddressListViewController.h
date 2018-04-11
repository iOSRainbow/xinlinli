//
//  GetAddressListViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/2/27.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetAddressListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray * dataArray;
    UITableView * tableview;
    NSInteger cellTag;
    
}
@property(nonatomic,strong)NSString*fromView;
@end
