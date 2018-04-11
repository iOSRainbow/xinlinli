//
//  LSFUtil.h
//  rainbow
//
//  Created by 李世飞 on 17/1/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSFUtil : NSObject


#pragma  mark 创建UILable
+(UILabel*)labelName:(NSString*)text   fontSize:(UIFont*)font  rect:(CGRect)rect View:(UIView*)viewA Alignment:(NSTextAlignment)alignment Color:(UIColor*)color Tag:(NSInteger)tag;

#pragma  mark 创建UITextField
+(UITextField*)addTextFieldView:(CGRect)rect Tag:(NSInteger)tag  textColor:(UIColor*)color Alignment:(NSTextAlignment)alignment Text:(NSString*)textStr  placeholderStr:(NSString *)placeholderStr View:(UIView*)viewA font:(UIFont*)font;


#pragma  mark 创建UITableView
+(UITableView *)add_tableview:(CGRect)rect Tag:(NSInteger) tag View:(UIView *)ViewA delegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource;


#pragma  mark 创建UIScrollView
+(UIScrollView *)add_scollview:(CGRect)rect Tag:(NSInteger) tag View:(UIView *)ViewA  co:(CGSize)co;


#pragma  mark 创建一条直线
+(UILabel *)setXianTiao:(UIColor *)color rect:(CGRect)rect view:(UIView *)View;


#pragma mark 创建一条虚线
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame view:(UIView *)view
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

#pragma mark 创建UIView
+(UIView *)viewWithRect:(CGRect)rect view:(UIView *)viewA backgroundColor:(UIColor *)color;

#pragma mark 创建UIImageView
+(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect View:(UIView*)viewA Tag:(NSInteger)tag;

#pragma mark 创建UIButton
+(UIButton*)buttonPhotoAlignment:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title   Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size;


#pragma mark 创建UIPickerView
+(UIPickerView *)pickerView:(CGRect)rect view:(UIView *)view dataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate;


#pragma mark 创建NSMutableAttributedString+Button
+(NSMutableAttributedString*)ButtonAttriSring:(NSString *)title color:(UIColor*)color image:(NSString*)image type:(NSInteger)type rect:(CGRect)rect;


+(NSMutableAttributedString*)AttributedString:(NSString*)title font:(UIFont*)font color:(UIColor*)color title1:(NSString*)title1 ;

+(LPlaceholderTextView*)addTextView:(CGRect)rect Tag:(NSInteger)tag  textColor:(UIColor*)color Alignment:(NSTextAlignment)alignment Text:(NSString*)textStr  placeholderStr:(NSString *)placeholderStr View:(UIView*)viewA font:(UIFont*)font;

+(UIView *)addEmptyView:(CGRect)rect view:(UIView *)view1 title:(NSString*)title;

+(void)donghuaView:(UIView*)view  Rect:(CGRect)rect;
@end
