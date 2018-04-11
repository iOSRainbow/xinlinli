//
//  ModfiyBusViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/23.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothUtils.h"

@interface ModfiyBusViewController : CommonViewController<BluetoothUtilsDelegate>{

    UITextField * pText1,*pText2,*pText3;

}

@property(strong,nonatomic)BluetoothUtils *modfiyBluetooth;
@property(nonatomic,strong)NSDictionary *dict;

@end
