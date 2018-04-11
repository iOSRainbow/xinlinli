//
//  CommentListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableview;
    NSMutableArray * dataArray;

}
@property(nonatomic,strong)NSString*goodsId;
@end
