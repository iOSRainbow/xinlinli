//
//  Mine_SexViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_SexViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
   
    UITableView * tableview;
    NSMutableArray * dataArray,*gouArray;
    NSInteger sex;
    

}

@property(nonatomic,strong)NSString * SexStr;

@end
