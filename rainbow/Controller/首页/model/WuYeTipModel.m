//
//  WuYeTipModel.m
//  rainbow
//
//  Created by 李世飞 on 2018/4/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "WuYeTipModel.h"

@implementation WuYeTipModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    self.title=[NSString stringWithFormat:@"公告标题: %@",dict[@"title"]];
    self.content=[NSString stringWithFormat:@"公告内容: %@",dict[@"content"]];
    self.content_height=[LSFEasy getLabHeight:self.content FontSize:font14 Width:SCREEN_WIDTH-15];
    
    self.cellName=dict[@"cellName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dict[@"date"] integerValue]/1000];
    self.date= [formatter stringFromDate:confromTimesp];
    
    self.picArray=dict[@"infophotos"];
    self.idStr=[NSString stringWithFormat:@"%@",dict[@"id"]];
    
    if(self.picArray.count==0){
        
        self.picView_height=0;
        
    }else if (self.picArray.count>=1&&self.picArray.count<=3){
        
        self.picView_height=100;
    }
    else{
        
        self.picView_height=200;

    }
    
    return self;
}
@end
