//
//  ActvityCell.m
//  rainbow
//
//  Created by 李世飞 on 2018/3/6.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ActvityCell.h"

@implementation ActvityCell
- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
       
        self.pic=[LSFUtil addSubviewImage:nil rect:CGRectMake((self.frame.size.width-60)/2, 0, 60,60) View:self Tag:1];
        
        
        self.labName=[LSFUtil labelName:nil fontSize:font12 rect:CGRectMake(0,55,self.frame.size.width, 35) View:self Alignment:1 Color:black Tag:2];
        
    }
    
    return self;
}


    

@end
