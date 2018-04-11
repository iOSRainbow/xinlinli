//
//  OpeationBusViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "OpeationBusViewController.h"
#import "BusLockViewController.h"
#import "AddLockViewController.h"
#import "ModfiyBusViewController.h"
@interface OpeationBusViewController ()

@end

@implementation OpeationBusViewController

-(void)donghuaView:(UIView*)view  Rect:(CGRect)rect{
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.5f];
    [view setFrame:rect];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    [UIView commitAnimations];
}
-(void)actNavRightBtn{

    [self donghuaView:backView Rect:CGRectMake(SCREEN_WIDTH-100, NavigationHeight, 100, 250)];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self donghuaView:backView Rect:CGRectMake(SCREEN_WIDTH+100,NavigationHeight, 100, 250)];

}

-(void)allocBackView{
 
    backView=[LSFUtil viewWithRect:CGRectMake(SCREEN_WIDTH+100,NavigationHeight, 100, 250) view:self.view backgroundColor:MS_RGBA(0,0,0,0.4)];
    
    NSArray * ary=@[@"添加车位锁",@"修改密码",@"删除车位",@"重连"];
    
    for(int i=0;i<ary.count;i++){
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, i*60,100, 60) title:ary[i] select:@selector(BackAction:) Tag:i View:backView textColor:white Size:font15 background:nil];
        
    }


}

-(void)BackAction:(UIButton*)btn{

    if(btn.tag==3){
    
        
        if([LSFEasy isEmpty:passwrod]){
            
            [self showHint:@"请先选择车位锁名称"];
            return;
        }
     

        [self startScanBle];
        
    }else if (btn.tag==2){
    
        if([LSFEasy isEmpty:passwrod]){
        
            [self showHint:@"请先选择车位锁名称"];
            return;
        }
        
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否删除车位" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            passwrod=@"";
            timeStr=@"";
            [busBtn setTitle:@"" forState:normal];
            itemDic=[[NSDictionary alloc] init];
            
            NSArray *array=[myUserDefaults objectForKey:@"data_bus"];
            NSMutableArray * ary=[[NSMutableArray alloc] init];
            if (array.count!=0) {
                ary=[array mutableCopy];
                
                [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if(![obj[@"time"] isEqual:timeStr]){
                        
                        [ary removeObjectAtIndex:idx];
                        
                        [myUserDefaults setObject: ary forKey:@"data_bus"];
                        
                        [myUserDefaults synchronize];
                        
                        *stop=YES;
                    }
                    
                }];
                
            }
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    
    }else if (btn.tag==1){
    
        if([LSFEasy isEmpty:passwrod]){
            
            [self showHint:@"请先选择车位锁名称"];
            return;
        }
        if([statusLb.text isEqualToString:@"当前蓝牙状态:未连接"]){
            
            [self showHint:@"请先连接蓝牙设备"];
            return;
        }
        
        ModfiyBusViewController * m =[[ModfiyBusViewController alloc] init];
        m.modfiyBluetooth=_mBluetoothUtils;
        m.dict=itemDic;
        m.completeBlockNSDictionary=^(NSDictionary*dic){
           
            passwrod=dic[@"password"];
            timeStr=dic[@"time"];
            itemDic=dic;
            [busBtn setTitle:dic[@"name"] forState:normal];
            [self startScanBle];

            
        };
        [self.navigationController pushViewController:m animated:YES];
        
    
    }else{
    
        AddLockViewController * add =[[AddLockViewController alloc] init];
        add.completeBlockNSDictionary=^(NSDictionary*dic){
        
            passwrod=dic[@"password"];
            timeStr=dic[@"time"];
            itemDic=dic;
            [busBtn setTitle:dic[@"name"] forState:normal];
            [self startScanBle];

        };
        [self.navigationController pushViewController:add animated:YES];
    }

    [self donghuaView:backView Rect:CGRectMake(SCREEN_WIDTH+100, 65, 100, 250)];

}

-(void)startScanBle{

    statusLb.text=@"当前蓝牙状态:未连接";
    
    [self showHudInView:self.view hint:@"开始扫描周边蓝牙设备"];
    [_mBluetoothUtils beginScan:3 withServiceUUID:@[[CBUUID UUIDWithString:@"0000fff0-0000-1000-8000-00805f9b34fb"]]];
}
-(void)ChooseBusAction{

    BusLockViewController * bus =[[BusLockViewController alloc] init];
    bus.completeBlockNSDictionary=^(NSDictionary*dic){
    
        passwrod=dic[@"password"];
        timeStr=dic[@"time"];
        itemDic=dic;
        [busBtn setTitle:dic[@"name"] forState:normal];
        [self startScanBle];

    
    };
    [self.navigationController pushViewController:bus animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"车位开关"];
    [LSFUtil addSubviewImage:@"lsf72" rect:CGRectMake(SCREEN_WIDTH-20,StatusHeight+(44-29/2)/2, 7/2, 29/2) View:navView Tag:1];
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-90, StatusHeight+2, 90, 40) title:nil select:@selector(actNavRightBtn) Tag:1 View:navView textColor:nil Size:nil background:nil];
    
    dataArray=[[NSMutableArray alloc] init];
    passwrod=@"";
    timeStr=@"";
    itemDic=[[NSDictionary alloc] init];
    //蓝牙初始化
    _mBluetoothUtils = [[BluetoothUtils alloc]init];
    _mBluetoothUtils.BlueType=1;
    [_mBluetoothUtils initBLE];
    _mBluetoothUtils.delegate = self;
    
    
    [LSFUtil labelName:@"选择车位: " fontSize:font15 rect:CGRectMake(10,10+NavigationHeight, 90, 40) View:self.view Alignment:0 Color:black Tag:1];
    
    busBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(100, NavigationHeight+10, SCREEN_WIDTH-130, 40) title:nil select:@selector(ChooseBusAction) Tag:1 View:self.view textColor:black Size:font14 background:white];
    busBtn.layer.cornerRadius=4;
    busBtn.layer.masksToBounds=YES;
    busBtn.layer.borderWidth=1;
    busBtn.layer.borderColor=[ColorHUI CGColor];
    
    statusLb=[LSFUtil labelName:@"当前蓝牙状态:未连接" fontSize:font15 rect:CGRectMake(10, NavigationHeight+70,self.view.frame.size.width-20, 20) View:self.view Alignment:0 Color:black Tag:1];
    
    
    [LSFUtil addSubviewImage:@"lsf71" rect:CGRectMake((SCREEN_WIDTH-275)/2,NavigationHeight+130, 275, 171) View:self.view Tag:1];
    
    
    UIButton * btn1=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, SCREEN_HEIGHT-100, 70,70) title:@"升起" select:@selector(Action:) Tag:1 View:self.view textColor:white Size:font18 background:[UIColor blueColor]];
    btn1.layer.cornerRadius=35;
    btn1.layer.masksToBounds=YES;
    
    
    UIButton * btn2=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-90, SCREEN_HEIGHT-100, 70,70) title:@"降下" select:@selector(Action:) Tag:2 View:self.view textColor:white Size:font18 background:MS_RGB(250,82,2)];
    btn2.layer.cornerRadius=35;
    btn2.layer.masksToBounds=YES;
    
    
    [self allocBackView];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if(peripheralConnect){
    [_mBluetoothUtils.CM cancelPeripheralConnection:peripheralConnect];
    }

}
#pragma BluetoothUtils Delegate

//扫描结果回掉
- (void)ScanCompleteNotify{
    
    [self hideHud];
    
    [dataArray removeAllObjects];
    
    
    for (int i=0;i<_mBluetoothUtils.peripherals.count;i++)
    {
        CBPeripheral *peripheral = _mBluetoothUtils.peripherals[i];
        NSString *string = [NSString stringWithFormat:@"%@",peripheral.name];
        if([string isEqual:itemDic[@"info"]]){
        [dataArray addObject:string];
        peripheralConnect=peripheral;
        [self.mBluetoothUtils connectPeripheral:peripheral];
        statusLb.text=@"当前蓝牙状态:连接中";
        return;
        }
    }
    
    if(dataArray.count==0){
        
    [self showHint:@"未扫描到周边蓝牙设备,请重试"];
    statusLb.text=@"当前蓝牙状态:未连接";
    }
}


//连接失败
- (void)DisconnectNotify{
    
    [self hideHud];
    [self showHint:@"连接失败,请重试"];
    statusLb.text=@"当前蓝牙状态:连接失败,点击重试";
    
}
//发现服务-特征--订阅
- (void)CharacterDiscCompleteNotify{
    
    [self hideHud];
    [self showHint:@"连接成功"];
    statusLb.text=@"当前蓝牙状态:己连接";
}

-(void)Action:(UIButton*)btn{
    
    if([LSFEasy isEmpty:passwrod]){
        
        [self showHint:@"请先选择车位锁名称"];
        return;
    }
    if([statusLb.text isEqualToString:@"当前蓝牙状态:未连接"]){
    
        [self showHint:@"请先连接蓝牙设备"];
        return;
    }
    
    if(btn.tag==1){
        
        [self showHint:@"发送升起指令"];
        NSData * data =[[NSString stringWithFormat:@"%@UA0200000",passwrod] dataUsingEncoding:NSUTF8StringEncoding];
        [_mBluetoothUtils writeValue:_mBluetoothUtils.activePeripheral data:data];
    }
    else{
        
        [self showHint:@"发送降下指令"];

        NSData * data =[[NSString stringWithFormat:@"%@UA0100000",passwrod] dataUsingEncoding:NSUTF8StringEncoding];
        
        [_mBluetoothUtils writeValue:_mBluetoothUtils.activePeripheral data:data];
    }
    
}
- (void)DataComeNotify:(NSData*)data{

    [self showHint:@"操作成功"];

}

-(void)DataFailNotify{

    [self showHint:@"操作失败"];

}
@end
