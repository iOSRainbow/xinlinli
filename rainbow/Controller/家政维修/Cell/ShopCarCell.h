//
//  ShopCarCell.h
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"

@interface ShopCarCell : UITableViewCell

@property(nonatomic,strong)UIImageView * shopSeletedImg;
@property(nonatomic,strong)UIImageView * shopImg;
@property(nonatomic,strong)UILabel * shopNameLb;
@property(nonatomic,strong)UILabel * shopPriceLb;
@property(nonatomic,strong)UILabel * shopNumLb;
@property(nonatomic,strong)UIButton * addBtn;
@property(nonatomic,strong)UIButton * removeBtn;
@property(nonatomic,strong)UILabel * line;


@property(nonatomic,strong)ShopCarModel * model;


@end
