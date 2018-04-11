//
//  Friend.h
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property(nonatomic,strong)NSString*headPicUrl;
@property(nonatomic,strong)NSString*nickName;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSMutableArray *photoListAry;
@property(nonatomic,strong)NSString* cellName;
@property(nonatomic,strong)NSString * dianzanNumStr;
@property(nonatomic,strong)NSString* pinglunNumStr;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat Contentheight;
@property(nonatomic,assign)CGFloat Photoheight;

@property(nonatomic,strong)NSString*date;

@property(nonatomic,strong)NSString*friendId;

@end
