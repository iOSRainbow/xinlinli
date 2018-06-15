//
//  KddSocket.h
//  deyingSoft
//
//  Created by 李世飞 on 17/3/3.
//  Copyright © 2017年 世飞-大有. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "AsyncSocket.h"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \


enum{
    SocketOfflineByServer,//服务器掉线
    SocketOfflineByUser,//用户手动断点
};

@protocol SocketDelegate <NSObject>

//接收数据
-(void)message:(NSDictionary*)dic;

@end


@interface KddSocket : NSObject<AsyncSocketDelegate>

@property (nonatomic, strong) AsyncSocket *socket;       // socket


@property(nonatomic,strong)NSData * SendToSocketData;


+ (KddSocket *)sharedInstance;

-(void)socketConnectHost;// socket连接

-(void)cutOffSocket;// 断开socket连接

@property (nonatomic,assign)id<SocketDelegate> delegate;


@end
