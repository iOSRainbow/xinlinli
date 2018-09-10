//
//  ShopCarModel.h
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject

@property(nonatomic,strong)NSString * shopName;
@property(nonatomic,strong)NSString * shopPrice;
@property(nonatomic,strong)NSString * shopNum;
@property(nonatomic,strong)NSString * shopImg;
@property(nonatomic,strong)NSString * shopId;
@property(nonatomic,assign)BOOL  isSeleted;


- (instancetype)initWithSubDict:(NSDictionary *)dict;



@end
