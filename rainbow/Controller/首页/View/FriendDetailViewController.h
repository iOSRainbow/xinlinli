//
//  FriendDetailViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface FriendDetailViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{

    NSDictionary*itemDic;
    UILabel * dianzanLb,*pinglunLb;
    NSMutableArray * dataArray;
    UITableView * tableview;
    UIView * keyTextView,*backView;
    LPlaceholderTextView * keyText;
    NSInteger cellTag,type;

}

@property(nonatomic,strong)Friend * friendModel;
@end
