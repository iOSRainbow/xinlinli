//
//  AppDelegate.h
//  rainbow
//
//  Created by 李世飞 on 17/1/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{

    NSInteger tabTag;

}

@property (strong, nonatomic) UIWindow *window;

@property BOOL isWeiPay;//是否正在进行微信支付


+ (AppDelegate *)sharedAppDelegate;


-(void)StartMain;


@end

