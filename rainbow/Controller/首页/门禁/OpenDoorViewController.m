//
//  OpenDoorViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/7/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "OpenDoorViewController.h"

@interface OpenDoorViewController ()

@end

@implementation OpenDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"门禁"];
    
    self.view.backgroundColor=white;
    
    dataArray=[[NSMutableArray alloc] init];
    //蓝牙初始化
    _mBluetoothUtils = [[BluetoothUtils alloc]init];
    _mBluetoothUtils.BlueType=2;
    [_mBluetoothUtils initBLE];
    _mBluetoothUtils.delegate = self;
    
    [self startScan];
   
    
    [LSFUtil labelName:@"访客密码" fontSize:font14 rect:CGRectMake(10,20+NavigationHeight, 80, 30) View:self.view Alignment:0 Color:gray Tag:1];
    
    pswLalbe=[LSFUtil labelName:@"点击按钮获取访客密码" fontSize:font14 rect:CGRectMake(90, 20+NavigationHeight, SCREEN_WIDTH-160, 30) View:self.view Alignment:1 Color:gray Tag:2];
    pswLalbe.layer.cornerRadius=5;
    pswLalbe.layer.masksToBounds=YES;
    pswLalbe.layer.borderWidth=1;
    pswLalbe.layer.borderColor=[ColorHUI CGColor];
    
    
    UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-60, NavigationHeight+20, 50, 30) title:@"获取" select:@selector(Action:) Tag:1 View:self.view textColor:gray Size:font14 background:white];
    btn.layer.cornerRadius=3;
    btn.layer.masksToBounds=YES;
    btn.layer.borderWidth=1;
    btn.layer.borderColor=[ColorHUI CGColor];
    
    [LSFUtil labelName:[NSString stringWithFormat:@"%@ %@",_Dic[@"cellName"],_Dic[@"buildingName"]] fontSize:font14 rect:CGRectMake(10, NavigationHeight+70, SCREEN_WIDTH-20, 30) View:self.view Alignment:1 Color:black Tag:1];

    
    [self buttonPhotoAlignment:@"lsf94" hilPhoto:@"lsf94" rect:CGRectMake((SCREEN_WIDTH-447/2)/2, 160+(SCREEN_HEIGHT-160-451/2)/2, 447/2, 451/2) title:@"" select:@selector(Action:) Tag:2 View:self.view textColor:gray Size:font14 background:white];

}
-(void)startScan{


    [self showHudInView:self.view hint:@"开始扫描周边蓝牙设备"];
    [_mBluetoothUtils beginScan:3 withServiceUUID:@[[CBUUID UUIDWithString:@"0000A001-0000-1000-8000-00805f9b34fb"]]];
    

}
-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"doorinfo_getPassword"];
        [api doorinfo_getPassword:_Dic[@"id"]];
    
    
    }else{
    
        if(dataArray.count==0){
        
            [self startScan];
            return;
        }
    
        [self showHint:@"正在开门..."];
        
        Byte EquipmenByte[12];
        Byte PswByte[4];
        
        NSData * EquipmenData=[_Dic[@"equipmen"] dataUsingEncoding:NSUTF8StringEncoding];
        Byte *testByte = (Byte *)[EquipmenData bytes];
        for(int i=0;i<[EquipmenData length];i++)
        {
            EquipmenByte[i]=testByte[i];
        }
    

        NSInteger num = (arc4random() % 10000);
        psw = [NSString stringWithFormat:@"%.4zi", num];
        NSData * PswData=[psw dataUsingEncoding:NSUTF8StringEncoding];
        Byte *testByte1 = (Byte *)[PswData bytes];
        for(int i=0;i<[PswData length];i++)
        {
            PswByte[i]=testByte1[i];
        }
        
        
        Byte table1[]={0x8e,0xb5,0x01};
        Byte table2[]={0xac};

        NSData *adata1 = [[NSData alloc] initWithBytes:table1 length:sizeof(table1)];

        NSData *adata2 = [[NSData alloc] initWithBytes:EquipmenByte length:sizeof(EquipmenByte)];
        
        NSData *adata3 = [[NSData alloc] initWithBytes:PswByte length:sizeof(PswByte)];
        
        NSData *adata4 = [[NSData alloc] initWithBytes:table2 length:sizeof(table2)];

        NSMutableData * data=[[NSMutableData alloc] init];//初始化一个可变data
        [data appendData:adata1];
        [data appendData:adata2];//拼接
        [data appendData:adata3];//拼接
        [data appendData:adata4];//拼接
        
        NSLog(@"%@",data);
        [_mBluetoothUtils writeValue:_mBluetoothUtils.activePeripheral data:data];
        
        // <8eb50130 30545948 59303130 33303339 34b3ac>

}

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self hideHud];

    if(peripheralConnect){
        [_mBluetoothUtils.CM cancelPeripheralConnection:peripheralConnect];
    }
    
    _mBluetoothUtils.delegate = nil;

}

//扫描结果回掉
- (void)ScanCompleteNotify{
    
    [self hideHud];
    
    [dataArray removeAllObjects];
    
    for (int i=0;i<_mBluetoothUtils.peripherals.count;i++)
    {
        CBPeripheral *peripheral = _mBluetoothUtils.peripherals[i];
        NSString *string = [NSString stringWithFormat:@"%@",peripheral.name];
        if([string isEqual:_Dic[@"equipmen"]]){
            [dataArray addObject:string];
            peripheralConnect=peripheral;
            [self.mBluetoothUtils connectPeripheral:peripheral];
            return;
        }
    }
    
    if(dataArray.count==0){
        
        [self showHint:@"未扫描到周边蓝牙设备,请重试"];
    }
}

//连接失败
- (void)DisconnectNotify{
    
    [self hideHud];
    [self showHint:@"连接失败,请重试"];
    
}
//发现服务-特征--订阅
- (void)CharacterDiscCompleteNotify{
    
    [self hideHud];
    [self showHint:@"连接成功"];
    
    [_mBluetoothUtils notification:_mBluetoothUtils.activePeripheral];

}

- (void)DataComeNotify:(NSData*)data{
    
    [self hideHud];

    NSString *string = [[NSString alloc]initWithFormat:@"%@",data.description];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string==nil)
    {
        return;
    }
    // <8eb50130 30545948 59303130 33303339 34b3ac>

    if(string.length>=6){
    
        NSString*str =[string substringWithRange:NSMakeRange(4, 2)];
        if([str isEqualToString:@"02"]){
        
            
            [self showHudInView:self.view hint:@"加载中"];
            Api * api =[[Api alloc] init:self tag:@"doorinfo_update"];
            [api doorinfo_update:_Dic[@"id"] password:psw];
        
        }else{
        
            [self showHint:@"操作失败"];

        }
    
    }
    
    
}

-(void)DataFailNotify{

    [self hideHud];
    [self showHint:@"操作失败"];
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    if([tag isEqualToString:@"doorinfo_getPassword"]){
    
        NSDictionary * dic=response[@"data"];
        pswLalbe.text=dic[@"password"];
    }else{
    
        [self showHint:@"开门成功"];
    
    }

}
@end
