//
//  LSFEasy.m
//  rainbow
//
//  Created by 李世飞 on 17/1/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "LSFEasy.h"

@implementation LSFEasy


#pragma mark 16进制转color
+( UIColor *) getColor:( NSString *)hexColor{

    unsigned int red, green, blue;
    
    NSRange range;
    
    range. length = 2 ;
    
    range. location = 0 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&red];
    
    range. location = 2 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&green];
    
    range. location = 4 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&blue];
    
    return [ UIColor colorWithRed :( float )(red/ 255.0f ) green :( float )(green/ 255.0f ) blue :( float )(blue/ 255.0f ) alpha : 1.0f ];
    

}

#pragma mark 动态计算label的高度
+ (CGFloat)getLabHeight:(id)text FontSize:(UIFont*)fontsize Width:(NSInteger)width{

    NSMutableParagraphStyle *paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineBreakMode=NSLineBreakByCharWrapping;
    NSDictionary *attributs=[NSDictionary dictionaryWithObjectsAndKeys:fontsize,NSFontAttributeName,[paraStyle copy],NSParagraphStyleAttributeName,nil];
    
    CGRect rect;
    if([text isKindOfClass:[NSString class]])
    {
        rect=[text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributs context:nil];
    }
    else if([text isKindOfClass:[NSAttributedString class]])
    {
        rect=[text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    }
    
    CGSize theSize=rect.size;
    return theSize.height;

}

#pragma mark 动态计算label的宽度
+ (CGFloat)getLabWidth:(id)text FontSize:(CGFloat)fontsize Height:(NSInteger)height{

    NSMutableParagraphStyle *paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineBreakMode=NSLineBreakByCharWrapping;
    NSDictionary *attributs=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontsize],NSFontAttributeName,[paraStyle copy],NSParagraphStyleAttributeName,nil];
    
    CGRect rect;
    if([text isKindOfClass:[NSString class]])
    {
        rect=[text boundingRectWithSize:CGSizeMake(999999.0f,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributs context:nil];
    }
    else if([text isKindOfClass:[NSAttributedString class]])
    {
        rect=[text boundingRectWithSize:CGSizeMake(999999.0f,height) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    }
    CGSize theSize=rect.size;
    return theSize.width;

}


#pragma mark 获得当前版本号
+(NSString *)getAppVersion{

    NSDictionary * infoDictionary =[[NSBundle mainBundle] infoDictionary];
    
    NSString * app_Version=[infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
}

//判断对象是否为空
+(BOOL)isEmpty:(id)obj
{
    if(obj == nil)
    {
        return YES;
    }
    else if([obj isKindOfClass:[NSString class]])
    {
        NSString *objStr = (NSString *)obj;
        if ([objStr isEqual:@""])
        {
            return YES;
        }
        if(objStr.length == 0)
        {
            return YES;
        }
    }
    else if([obj isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else
    {
    }
    return NO;
}

//手机号正则
+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[01235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //虚拟运行商号段
    NSString *VT=@"^17\\d{9}";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestvt=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",VT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        ||([regextestvt evaluateWithObject:mobileNum]==YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//获取现在日期
+(NSString*)getNowDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date= [dateFormatter stringFromDate:[NSDate date]];
    return date;
}

//获取现在时间
+(NSString*)getNowTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *date= [dateFormatter stringFromDate:[NSDate date]];
    return date;
}
+ (NSDate *)dateFromString:(NSString *)dateStr type:(NSInteger)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:type==1?@"YYYY-MM-dd":@"HH:mm"];
    
    NSDate *destDate = [dateFormatter dateFromString:dateStr];
    
    return destDate;
    
}


#pragma mark - 支付的处理方法
+(void)wechatpay:(NSString*)requestData
{
    NSData *data=[requestData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* payinfo=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSDictionary* payinfo = [requestData JSONValue];
    
    NSLog(@"payinfo:%@", payinfo);
    
    NSString* noncestr = [payinfo objectForKey:@"noncestr"];
    NSString* partnerid = [payinfo objectForKey:@"partnerid"];
    NSString* prepayid = [payinfo objectForKey:@"prepayid"];
    NSNumber* timestamp = [payinfo objectForKey:@"timestamp"];
    NSString* sign = [payinfo objectForKey:@"sign"];
    NSString* packageValue = [payinfo objectForKey:@"packageValue"];
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepayid;
    request.package = packageValue;
    request.nonceStr= noncestr;
    request.timeStamp= [timestamp intValue];
    request.sign= sign;
    
    //会跳转到微信界面
    [WXApi sendReq:request];
    
    
    [AppDelegate sharedAppDelegate].isWeiPay=YES;
    
}


+(NSMutableAttributedString*)ButtonAttriSring:(NSString *)title color:(UIColor*)color image:(NSString*)image type:(NSInteger)type rect:(CGRect)rect
{
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:image];
    // 设置图片大小
    attch.bounds =rect;
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title]];
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri addAttribute:NSForegroundColorAttributeName
     
                  value:color
     
                  range:NSMakeRange(0, title.length)];
    
    if(type==1){
        [attri insertAttributedString:string atIndex:0];
    }else{
        [attri appendAttributedString:string];
    }
    
    return attri;
    
}

@end
