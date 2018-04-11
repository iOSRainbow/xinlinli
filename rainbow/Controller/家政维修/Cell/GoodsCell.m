//
//  GoodsCell.m
//  rainbow
//
//  Created by 李世飞 on 17/8/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.goodPic=[LSFUtil addSubviewImage:nil rect:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.width-10) View:self Tag:1];
        
        self.goodName=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(5,self.goodPic.frame.size.height+5,self.frame.size.width-10, 25) View:self Alignment:1 Color:white Tag:2];
        self.goodName.backgroundColor=orange;
        
        self.goodContent=[LSFUtil labelName:nil fontSize:font12 rect:CGRectMake(5, self.goodPic.frame.size.height+30,self.frame.size.width-10, 40) View:self Alignment:0 Color:gray Tag:3];
        
        
        self.goodPrice=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(5, self.goodPic.frame.size.height+70, self.frame.size.width-10, 20) View:self Alignment:0 Color:gray Tag:4];
        
    }
    
    return self;
}
@end
