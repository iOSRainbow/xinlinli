//
//  AppDelegate.m
//  rainbow
//
//  Created by 李世飞 on 17/1/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "MainTabViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LeadViewController.h"
#import "JPUSHService.h"
// iOS10注册APNs所需头 件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

static NSString *appKey = @"dd98116abf5fbae41849bb30";
static NSString *channel = @"Publish channel";
static BOOL isProduction = NO;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    [NSThread sleepForTimeInterval:1];//启动页驻留时间加长
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];

  //  [WXApi registerApp:@"wxd45ec89e2b4f0d2c" withDescription:@"新邻里"];
    
    //注册极光推送
   [self registerJpush:launchOptions];
    
    LeadViewController *lvc=[[LeadViewController alloc]init];
    _window.rootViewController=lvc;
    
    return YES;
}

+(AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

-(void)StartMain{

    NSString * token =[myUserDefaults objectForKey:@"token"];
    if([LSFEasy isEmpty:token]){
    
        LoginViewController * login =[[LoginViewController alloc] init];
        UINavigationController * navi=[[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController=navi;
    }
    else{
    
        MainTabViewController * maintab =[[MainTabViewController alloc] init];
        maintab.selectedIndex=2;
        self.window.rootViewController=maintab;
    
    }
    

}

#pragma mark - 极光推送相关
-(void)registerJpush:(NSDictionary *)launchOptions
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
        
        
    }
    
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}


//ios8以后方法
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}



#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif


/*
#pragma mark - WXApiDelegate
-(void) onReq:(BaseReq*)req
{
    NSLog(@"onReq");
    
}

//微信支付或者分享成功后,会回调下面方法
-(void) onResp:(BaseResp*)resp
{
    NSLog(@"微信返回啦!!");
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", response.errCode];
        NSLog(@"支付结果:%@",strMsg);
        switch (response.errCode) {
            case WXSuccess: {
                NSLog(@"支付成功:客户端");
                [self postNotification:@"payment.done"];
                break;
            }
            default: {
                NSLog(@"交易失败:wap");
                [self postNotification:@"payment.false"];
                break;
            }
        }
    }
    
}
*/
- (void)parse:(NSURL *)url application:(UIApplication *)application {
    //支付结束后,从支付宝(微信)返回到kdd
    if ([url.host isEqualToString:@"safepay"]) {
        NSLog(@"支付宝支付返回啦!!");
        //支付宝
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSNumber* resultStatus = [resultDic objectForKey:@"resultStatus"];
            if(resultStatus && [resultStatus intValue]==9000) {
                NSLog(@"支付成功:客户端");
                //[NSThread sleepForTimeInterval:1];//停1s给后台点时间
                [self postNotification:@"payment.done"];
            }
            else
            {
                [self postNotification:@"payment.false"];
            }
        }];
    }
}


#pragma mark - 发送通知
-(void)postNotification:(NSString*)notificationName
{
    NSLog(@"notification:%@", notificationName);
    NSNotificationCenter * notifyCenter = [NSNotificationCenter defaultCenter];
    NSNotification *nnf = [NSNotification notificationWithName:notificationName object:nil];
    [notifyCenter postNotification:nnf];
}


//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。(其他应用返回该应用时的回调函数)
//此方法已被9.0弃用
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"<99999url string=%@",[url absoluteString]);
    //用于处理支付宝的返回
    [self parse:url application:application];
    
    
    //处理微信 通过URL启动App时传递过来的数据
    if(self.isWeiPay)
    {
        self.isWeiPay=NO;
        return [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        
        return YES;
    }
}

//9.0以后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"999999url string=%@",[url absoluteString]);
    //用于处理支付宝的返回
    [self parse:url application:app];
    
   
    
    //处理微信 通过URL启动App时传递过来的数据
    if(self.isWeiPay)
    {
        self.isWeiPay=NO;
        return [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        
        return YES;
    }
    
}



@end
