//
//  GoodsCell.h
//  rainbow
//
//  Created by 李世飞 on 17/8/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView * goodPic;
@property(nonatomic,strong)UILabel * goodName;
@property(nonatomic,strong)UILabel * goodContent;
@property(nonatomic,strong)UILabel * goodPrice;

@end
