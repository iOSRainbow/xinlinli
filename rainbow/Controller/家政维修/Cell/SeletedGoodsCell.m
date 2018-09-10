//
//  SeletedGoodsCell.m
//  rainbow
//
//  Created by 李世飞 on 2018/8/10.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "SeletedGoodsCell.h"

@implementation SeletedGoodsCell

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
        
        _goodNameLab=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 0, SCREEN_WIDTH-140, 60) View:self Alignment:0 Color:black Tag:1];
        
        
        _removeBtn=[LSFUtil buttonPhotoAlignment:@"减号" hilPhoto:@"减号" rect:CGRectMake(SCREEN_WIDTH-124, 18, 24, 24) title:nil Tag:1 View:self textColor:nil Size:nil];
        
        
        _goodNumLab=[LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(SCREEN_WIDTH-100,0,60,60) View:self Alignment:1 Color:black Tag:2];
        
        
        _addBtn=[LSFUtil buttonPhotoAlignment:@"加号" hilPhoto:@"加号" rect:CGRectMake(SCREEN_WIDTH-40, 18, 24,24) title:nil Tag:2 View:self textColor:nil Size:nil];
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 59, SCREEN_WIDTH, 1) view:self];
        
    }
    return self;
}


-(void)setModel:(SeletedGoodsModel *)model{
    
    _goodNameLab.text=model.goodName;
    _goodNumLab.text=model.goodNum;
    _removeBtn.hidden=model.goodNum.integerValue==0?YES:NO;
    _goodNumLab.hidden=model.goodNum.integerValue==0?YES:NO;

}
@end
