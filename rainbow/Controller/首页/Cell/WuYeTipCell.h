//
//  WuYeTipCell.h
//  rainbow
//
//  Created by 李世飞 on 2018/4/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WuYeTipModel.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"



@interface WuYeTipCell : UITableViewCell
@property(nonatomic,strong)UILabel * lbTitle;
@property(nonatomic,strong)UILabel * lbContent;
@property(nonatomic,strong)UILabel * lbCellName;
@property(nonatomic,strong)UILabel * lbDate;
@property(nonatomic,strong)UIView * picView;
@property(nonatomic,strong)UILabel * line;

-(void)updataWithModel:(WuYeTipModel*)model;
@property(nonatomic,strong)WuYeTipModel* model;
@end
