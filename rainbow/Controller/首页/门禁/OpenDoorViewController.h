//
//  OpenDoorViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/7/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothUtils.h"

@interface OpenDoorViewController : CommonViewController<BluetoothUtilsDelegate>
{
    UILabel * pswLalbe;
    CBPeripheral *peripheralConnect;
    NSMutableArray*dataArray;
    NSString * psw;

}
@property(nonatomic,strong)NSDictionary * Dic;
@property(strong,nonatomic)BluetoothUtils *mBluetoothUtils;

@end
