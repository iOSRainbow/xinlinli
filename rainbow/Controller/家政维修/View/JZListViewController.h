//
//  JZListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZListViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    UITableView * nameTableview;
    NSMutableArray * nameArray,*goodsArray,*gouArray;
    UICollectionView * goodCollectionView;


}

@end
