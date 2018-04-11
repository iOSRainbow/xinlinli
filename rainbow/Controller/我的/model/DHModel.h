//
//  DHModel.h
//  rainbow
//
//  Created by 李世飞 on 2018/2/27.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHModel : NSObject

@property(nonatomic,strong)NSString*fullprice;
@property(nonatomic,strong)NSString*subprice;
@property(nonatomic,strong)NSString*type;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)NSString*begintime;
@property(nonatomic,strong)NSString*endtime;
@property(nonatomic,strong)NSString*vouchercellId;
@property(nonatomic,strong)NSString*voucherId;
@end
