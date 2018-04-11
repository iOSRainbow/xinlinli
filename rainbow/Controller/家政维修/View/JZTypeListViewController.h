//
//  JZTypeListViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/8/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTypeListViewController : CommonViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * dataArray;
    UICollectionView * goodCollectionView;

}

@property(nonatomic,assign)NSString* type;
@property(nonatomic,strong)NSString*name;

@end
