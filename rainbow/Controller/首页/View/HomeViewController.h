//
//  HomeViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : CommonViewController<FFScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * scr;

    NSMutableArray * dataArray,*goodsArray;
    
    UIView * mainView;
    
    UITableView * tableview;
    
    CGFloat height;
    

}
@end
