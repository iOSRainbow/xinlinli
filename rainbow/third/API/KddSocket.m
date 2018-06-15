//
//  KddSocket.m
//  deyingSoft
//
//  Created by 李世飞 on 17/3/3.
//  Copyright © 2017年 世飞-大有. All rights reserved.
//

#import "KddSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>



@implementation KddSocket

+(KddSocket *) sharedInstance
{
    
    static KddSocket *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}
// socket连接
-(void)socketConnectHost{
  
    self.socket= [[AsyncSocket alloc] initWithDelegate:self];
    
    NSError *error = nil;
    
    NSString * port =@"9999";
    
    [self.socket connectToHost:@"139.224.30.74" onPort:port.integerValue withTimeout:3 error:&error];
    
}
// 连接成功回调
#pragma mark  - 连接成功回调
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket连接成功");
    
    [self longConnectToSocket];
}

// 心跳连接
-(void)longConnectToSocket{
    
    NSLog(@"发送心跳包");
    
    Byte table[]={0x8e,0xb5,0x04,0x40};
    NSData *adata = [[NSData alloc] initWithBytes:table length:sizeof(table)];
    
    
    NSString * mobile =UserName;
    
    NSData * mobileData =[mobile dataUsingEncoding:NSUTF8StringEncoding];
    Byte * mobileByte =(Byte*)[mobileData bytes];
    Byte  mobileTable[mobileData.length];
    for(int i=0;i<[mobileData length];i++){
        
        mobileTable[i]=mobileByte[i];
     
    }
    
   
    NSData * adata1=[[NSData alloc] initWithBytes:mobileTable length:sizeof(mobileTable)];
    
    Byte table1[]={0x34,0xac};
    NSData * adata2=[[NSData alloc] initWithBytes:table1 length:sizeof(table1)];
    
    
    NSMutableData * data=[[NSMutableData alloc] init];//初始化一个可变data
    [data appendData:adata];
    [data appendData:adata1];
    [data appendData:adata2];

    
    [self.socket writeData:data withTimeout:1 tag:2];
    
    
    [self.socket writeData:self.SendToSocketData withTimeout:1 tag:1];
    
    [self.socket readDataWithTimeout:30 tag:2];
    
}

// 切断socket
-(void)cutOffSocket{
    
    self.socket.userData = SocketOfflineByUser;
    [self.socket disconnect];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
   if (sock.userData == SocketOfflineByUser) {
     
        // 如果由用户断开，不进行重连
        [self cutOffSocket];
    }
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSLog(@"data=%@\n\ntag=%zi",data,tag);
    
    Byte *testByte = (Byte *)[data bytes];
    
    if(testByte[3]==0x30){
        
        if(_delegate&&[_delegate respondsToSelector:@selector(message:)]){
            
            [_delegate message:@{@"message":@"门锁信息不匹配，请重试",@"sucess":@"0"}];
        }
    }else if (testByte[3]==0x31){
        
        if(_delegate&&[_delegate respondsToSelector:@selector(message:)]){
            
            [_delegate message:@{@"message":@"开门成功",@"sucess":@"1"}];
        }
    }else if (testByte[3]==0x32){
        
        if(_delegate&&[_delegate respondsToSelector:@selector(message:)]){
            
            [_delegate message:@{@"message":@"开门失败，请重试",@"sucess":@"0"}];
        }
    }
   
    
    [self.socket readDataWithTimeout:30 tag:1];

}


@end
