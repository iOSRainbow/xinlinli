//
//  SeletedGoodsCell.h
//  rainbow
//
//  Created by 李世飞 on 2018/8/10.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeletedGoodsModel.h"
@interface SeletedGoodsCell : UITableViewCell

@property(nonatomic,strong)UILabel * goodNameLab;
@property(nonatomic,strong)UILabel * goodNumLab;
@property(nonatomic,strong)UIButton * addBtn;
@property(nonatomic,strong)UIButton * removeBtn;

@property(nonatomic,strong)SeletedGoodsModel * model;
@end
