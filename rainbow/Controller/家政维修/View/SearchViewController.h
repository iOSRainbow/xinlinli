//
//  SearchViewController.h
//  rainbow
//
//  Created by 李世飞 on 2018/2/26.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCell.h"
#import "JZDetailViewController.h"
@interface SearchViewController : CommonViewController<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UITextField * searchText;
    NSMutableArray * dataArray;
    UICollectionView * goodCollectionView;

}
@end
