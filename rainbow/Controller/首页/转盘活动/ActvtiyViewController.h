//
//  ActvtiyViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/1/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RuleViewController.h"
#import "ActvityCell.h"
@interface ActvtiyViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIScrollView * scr;
    UIButton * startBtn;
    UILabel * jpLable;
    UITableView * tableview;
    NSInteger result;
    NSTimer * timer;
    NSString * prizesname,*username;
    
    
    NSMutableArray * gouArray;
    UICollectionView * collectionView;
    NSTimer * actvityTimer;
    NSInteger timerTag,endTimerTag,tag;
    NSArray * dataArray,*prizesrecordCustoms;

}
@end
