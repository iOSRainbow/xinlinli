//
//  BluetoothUtils.h
//  rainbow
//
//  Created by 李世飞 on 17/7/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

@protocol BluetoothUtilsDelegate <NSObject>
@optional
-(void) ScanNewPeripheralDevice:(CBPeripheral *)peripheral WithAdvertisementData:(NSDictionary*)advertiseData;

//扫描结果
-(void) ScanCompleteNotify;
-(void) ServiceDiscCompleteNotify;
-(void) CharacterDiscCompleteNotify;
-(void) DataComeNotify:(NSData*)data;
-(void) DataFailNotify;
-(void) DisconnectNotify;

-(void)rssiUpdate:(NSNumber *)rssi withPeripheral:(CBPeripheral *)p;
@end




@interface BluetoothUtils : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>{
    
    NSString* SPS_SERVICE_UUID;
    NSString* SPS_CHAR_UUID;
}

@property (nonatomic,assign) id <BluetoothUtilsDelegate> delegate;
@property (strong, nonatomic)  NSMutableArray *peripherals;
@property (strong, nonatomic) NSMutableArray *devRssi;
@property (strong, nonatomic) CBCentralManager *CM;//管理中心
@property (strong, nonatomic) NSTimer *scanTimer;
@property (strong, nonatomic) CBPeripheral *activePeripheral;//外设
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;

@property (strong, nonatomic) NSMutableData *readBuffer; //接受返回数据
@property(nonatomic,assign) NSInteger BlueType;//1，车位锁，2门禁

//For Class Use
-(void) getAllCharacteristics:(CBPeripheral *)p;
- (const char *)centralManagerStateToString:(int)state;
-(CBService *)findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p;
-(UInt16)swap:(UInt16)s ;
-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 ;
-(const char *)UUIDToString:(CFUUIDRef)UUID ;
-(const char *)CBUUIDToString:(CBUUID *) UUID ;
-(UInt16) CBUUIDToInt:(CBUUID *) UUID ;
-(CBCharacteristic *)findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service ;


//For User Use
- (int)initBLE;
- (int)beginScan:(int) timeout withServiceUUID:(NSArray *)uuids;
- (void)stopScan;
- (void)connectPeripheral:(CBPeripheral *)peripheral;
-(void) notification:(CBPeripheral *)p;
- (void) writeValue:(CBPeripheral *)p data:(NSData *)data;
- (void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p ;
-(NSData *)readSppData:(NSUInteger)length;

@end
