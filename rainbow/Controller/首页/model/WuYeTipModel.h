//
//  WuYeTipModel.h
//  rainbow
//
//  Created by 李世飞 on 2018/4/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WuYeTipModel : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * cellName;
@property(nonatomic,strong)NSString * date;
@property(nonatomic,strong)NSArray * picArray;
@property(nonatomic,strong)NSString * idStr;

@property(nonatomic,assign)CGFloat picView_height;
@property(nonatomic,assign)CGFloat content_height;


-(instancetype)initWithDictionary:(NSDictionary *)dict;




@end
