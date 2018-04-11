//
//  Mine_RlistViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_RlistViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray * dataArray,*gouArray,*scoreArray;
    UITableView * tableview;
    
    
}


@end
