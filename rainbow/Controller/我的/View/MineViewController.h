//
//  MineViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>
{

    UIScrollView * scr;
    
    UIImageView * headImgView;
    
    UILabel * nickNameLb,*intergalLb,*signLb,*collectLb;
    
    UITableView * tableview;
    
    NSMutableArray * dataArray,*imageArray;
    
    UIButton * signBtn;

}

@end
