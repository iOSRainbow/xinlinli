//
//  GetUserAddressViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetUserAddressViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * dataArray;
    UITableView*tableview;
    NSInteger cellTag;
    
}

@property(nonatomic,strong)NSString*fromView;

@end
