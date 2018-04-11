//
//  LSFEasy.h
//  rainbow
//
//  Created by 李世飞 on 17/1/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSFEasy : NSObject

#pragma mark 16进制转color
+( UIColor *) getColor:( NSString *)hexColor;

#pragma mark 动态计算label的高度
+ (CGFloat)getLabHeight:(id)text FontSize:(UIFont*)fontsize Width:(NSInteger)width;

#pragma mark 动态计算label的宽度
+ (CGFloat)getLabWidth:(id)text FontSize:(CGFloat)fontsize Height:(NSInteger)height;


#pragma mark 获得当前版本号
+(NSString *)getAppVersion;


#pragma mark 判断对象是否为空
+(BOOL)isEmpty:(id)obj;


+(BOOL)validateMobile:(NSString *)mobileNum;

//获取现在日期
+(NSString*)getNowDate;


//获取现在时间
+(NSString*)getNowTime;

+(NSDate *)dateFromString:(NSString *)dateStr type:(NSInteger)type;


#pragma mark - 支付的处理方法
+(void)wechatpay:(NSString*)requestData;


#pragma mark getHex
+(unsigned char)getHex:(unsigned char[2])value;


#pragma mark stringToHexData
+(NSData *)stringToHexData:(NSString *)string;



#pragma mark 将十六进制的字符串转换成NSString
+(NSString *)convertHexStrToString:(NSString *)str;
@end
