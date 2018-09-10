//
//  ShopCarModel.m
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel

- (instancetype)initWithSubDict:(NSDictionary *)dict
{
    self = [super init];
    if (self){
   
        NSDictionary * dic =dict[@"shoppingcar"];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dict[@"url"]];
        
        self.shopImg=url;
        self.shopNum=[NSString stringWithFormat:@"%@",dic[@"count"]];
        self.shopPrice=dic[@"discountPrice"];
        self.shopId=dic[@"id"];
        self.isSeleted=NO;
        
    }
    return self;
}
@end
