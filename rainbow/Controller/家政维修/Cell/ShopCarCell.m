//
//  ShopCarCell.m
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ShopCarCell.h"

@implementation ShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        _shopSeletedImg=[LSFUtil addSubviewImage:@"圈gray" rect:CGRectMake(10,30, 20, 20) View:self Tag:1];

        
        _shopImg=[LSFUtil addSubviewImage:nil rect:CGRectMake(40, 10, 60, 60) View:self Tag:1];
        
        _shopNameLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(120, 20, SCREEN_WIDTH-115, 20) View:self Alignment:0 Color:black Tag:2];
        
        _shopPriceLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(120, 45, SCREEN_WIDTH-220, 20) View:self Alignment:0 Color:Red Tag:3];
        
        
        _removeBtn=[LSFUtil buttonPhotoAlignment:@"减号" hilPhoto:@"减号" rect:CGRectMake(SCREEN_WIDTH-124, 45, 24, 24) title:nil Tag:1 View:self textColor:nil Size:nil];
        
        
        _shopNumLb=[LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(SCREEN_WIDTH-100,45,60,24) View:self Alignment:1 Color:black Tag:2];
        
        
        _addBtn=[LSFUtil buttonPhotoAlignment:@"加号" hilPhoto:@"加号" rect:CGRectMake(SCREEN_WIDTH-40, 45, 24,24) title:nil Tag:2 View:self textColor:nil Size:nil];
        
        
        _line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(40, 79, SCREEN_WIDTH, 1) view:self];
        
    }
    return self;
}

-(void)setModel:(ShopCarModel *)model{
    
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:model.shopImg] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    _shopNumLb.text=model.shopNum;
    
    _shopPriceLb.text=[NSString stringWithFormat:@"￥%@",model.shopPrice];
    
    _removeBtn.hidden=model.shopNum.integerValue==0?YES:NO;
    _shopNumLb.hidden=model.shopNum.integerValue==0?YES:NO;
    
    _shopSeletedImg.image=[UIImage imageNamed:model.isSeleted?@"圈orange":@"圈gray"];

}
@end
