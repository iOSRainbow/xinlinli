
//
//  WuYeTipCell.m
//  rainbow
//
//  Created by 李世飞 on 2018/4/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "WuYeTipCell.h"

@implementation WuYeTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.lbTitle=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-15, 20) View:self Alignment:0 Color:gray Tag:1];
        
        self.lbContent=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH-15, 20) View:self Alignment:0 Color:gray Tag:2];

        
        self.picView=[LSFUtil viewWithRect:CGRectMake(0, 50, SCREEN_WIDTH, 100) view:self backgroundColor:nil];
        
        
        self.lbCellName=[LSFUtil labelName:nil fontSize:font12 rect:CGRectMake(10, 150, SCREEN_WIDTH-110, 20) View:self Alignment:0 Color:gray Tag:3];
        
        self.lbDate=[LSFUtil labelName:nil fontSize:font12 rect:CGRectMake(SCREEN_WIDTH-110, 150, 105, 20) View:self Alignment:2 Color:gray Tag:4];
        
        self.line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 179, SCREEN_WIDTH, 1) view:self];

        
    }
    return self;
}


-(void)updataWithModel:(WuYeTipModel*)model{
    
    _model=model;
    self.lbDate.text=model.date;
    self.lbTitle.text=model.title;
    self.lbCellName.text=model.cellName;
    self.lbContent.text=model.content;
    
    self.picView.frame=CGRectMake(0,60, SCREEN_WIDTH, model.picView_height);
    self.lbCellName.frame=CGRectMake(10, model.picView_height+65, SCREEN_WIDTH-150, 20);
    self.lbDate.frame=CGRectMake(SCREEN_WIDTH-140, model.picView_height+65, 135, 20);
    
    self.line.frame=CGRectMake(0, model.picView_height+89, SCREEN_WIDTH, 1);

    [self.picView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    CGFloat itemBtnW = self.picView.frame.size.width/3;
    CGFloat itemBtnH = self.picView.frame.size.height/2;
    
    for(int i=0;i<model.picArray.count;i++){
        
        
        NSDictionary * dic =model.picArray[i];
        
        CGFloat itemBtnX = i/6 *self.picView.frame.size.width + (i%(6/2))*itemBtnW;
        CGFloat itemBtnY = ((i - (i/6)*6)/(6/2))*itemBtnH;
       
        UIView * view =[LSFUtil viewWithRect:CGRectMake(itemBtnX,itemBtnY,itemBtnW,itemBtnH) view:self.picView backgroundColor:white];

        UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake((view.frame.size.width-90)/2,5,90,90) View:view Tag:1];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=info",urlStr,dic[@"url"]];

        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
        UIButton * btn =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil Tag:i View:view textColor:nil Size:nil];
        [btn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)photo:(UIButton *)btn{
    
    NSArray * ary =_model.picArray;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [ary count]];
    
    for (int i = 0; i < [ary count]; i++) {
        // 替换为中等尺寸图片
        
        NSDictionary * dic=ary[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=info",urlStr,dic[@"url"]];
        
        photo.url=[NSURL URLWithString:url];
        
        [photo.srcImageView sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"lsf63"]];
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex =btn.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
@end
