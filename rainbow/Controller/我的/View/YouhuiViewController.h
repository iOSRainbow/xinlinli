//
//  YouhuiViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouhuiViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView * tableview;
    NSMutableArray * dataArray;
    NSInteger cellTag;

}

@property(nonatomic,strong)NSString*fromView;

@end
