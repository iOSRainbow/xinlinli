//
//  OpeationBusViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothUtils.h"

@interface OpeationBusViewController : CommonViewController<BluetoothUtilsDelegate>
{
    UILabel *statusLb;
    NSMutableArray*dataArray;
    UIView * backView;
    UIButton * busBtn;
    NSString * passwrod,*timeStr;
    NSDictionary * itemDic;
    CBPeripheral *peripheralConnect;

}
@property(strong,nonatomic)BluetoothUtils *mBluetoothUtils;




@end
