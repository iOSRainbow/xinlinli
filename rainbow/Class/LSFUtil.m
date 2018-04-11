//
//  LSFUtil.m
//  rainbow
//
//  Created by 李世飞 on 17/1/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "LSFUtil.h"

@implementation LSFUtil



#pragma  mark 创建UILable
+(UILabel*)labelName:(NSString*)text   fontSize:(UIFont*)font  rect:(CGRect)rect View:(UIView*)viewA Alignment:(NSTextAlignment)alignment Color:(UIColor*)color Tag:(NSInteger)tag{
    UILabel*label=[[UILabel alloc]initWithFrame:rect];
    label.text=text;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=alignment;
    label.textColor=color;
    label.numberOfLines=0;
    label.lineBreakMode=NSLineBreakByTruncatingTail;
    label.font =font;
    label.tag=tag;
    [viewA addSubview:label];
    
    return label;
}



#pragma  mark 创建UITextField
+(UITextField*)addTextFieldView:(CGRect)rect Tag:(NSInteger)tag  textColor:(UIColor*)color Alignment:(NSTextAlignment)alignment Text:(NSString*)textStr  placeholderStr:(NSString *)placeholderStr View:(UIView*)viewA font:(UIFont*)font{
    UITextField*textM=[[UITextField alloc] initWithFrame:rect];
    [textM setBackgroundColor:[UIColor clearColor]];
    [textM setTextColor:color];
    textM.tag=tag;
    textM.placeholder =placeholderStr;
    textM.font=font;
    textM.text=textStr;
    textM.autocapitalizationType=UITextAutocapitalizationTypeNone;
    textM.textAlignment = alignment;

    [viewA addSubview:textM];
    return textM;
}


#pragma  mark 创建UITableView
+(UITableView *)add_tableview:(CGRect)rect Tag:(NSInteger) tag View:(UIView *)ViewA delegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource{

    UITableView * tableview =[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableview.delegate=delegate;
    tableview.dataSource=dataSource;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableview.tag=tag;
    tableview.backgroundColor=[UIColor clearColor];
    
    
    if (@available(ios 11.0,*)) {
        tableview.estimatedRowHeight = 0;
        tableview.estimatedSectionFooterHeight = 0;
        tableview.estimatedSectionHeaderHeight = 0;
        [tableview setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    if(iPhoneX){
        tableview.contentInset=UIEdgeInsetsMake(0, 0, TabbarHeight, 0);
    }
    [ViewA addSubview:tableview];
    return tableview;
}


#pragma  mark 创建UIScrollView
+(UIScrollView *)add_scollview:(CGRect)rect Tag:(NSInteger) tag View:(UIView *)ViewA  co:(CGSize)co{

    UIScrollView * scrll=[[UIScrollView alloc] initWithFrame:rect];
    scrll.tag=tag;
    scrll.scrollEnabled=YES;
    scrll.contentSize=co;
    if (@available(ios 11.0,*)) {
        [scrll setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [ViewA addSubview:scrll];
    return scrll;
}

#pragma  mark 创建一条直线
+(UILabel *)setXianTiao:(UIColor *)color rect:(CGRect)rect view:(UIView *)View{

    UILabel * lable = [[UILabel alloc] initWithFrame:rect];
    lable.backgroundColor=color;
    [View addSubview:lable];
    return lable;
}

#pragma mark 创建一条虚线
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame view:(UIView *)view
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color{

    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    [view addSubview:dashedLine];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    
    return dashedLine;

    
}

#pragma mark 创建UIView
+(UIView *)viewWithRect:(CGRect)rect view:(UIView *)viewA backgroundColor:(UIColor *)color{

    UIView *view=[[UIView alloc]init];
    view.frame=rect;
    view.backgroundColor=color;
    [viewA addSubview:view];
    return view;
}


#pragma mark 创建UIImageView
+(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect View:(UIView*)viewA Tag:(NSInteger)tag{

    UIImageView*view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    view.frame=rect;
    view.userInteractionEnabled=YES;
    view.tag=tag;
    view.contentMode=UIViewContentModeScaleAspectFill;
    view.clipsToBounds=YES;
    [viewA addSubview:view];
    return view;
}

#pragma mark 创建UIButton
+(UIButton*)buttonPhotoAlignment:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title   Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size{

    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:photo] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:Hphoto] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    button.titleLabel.font=size;
    [ViewA addSubview:button];
    return button;

}


#pragma mark 创建UIPickerView
+(UIPickerView *)pickerView:(CGRect)rect view:(UIView *)view dataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate{

    UIPickerView * pickerView=[[UIPickerView alloc]initWithFrame:rect];
    pickerView.delegate=delegate;
    pickerView.dataSource=dataSource;
    [view addSubview:pickerView];
    return pickerView;

}


/**
 button
 
 @param title 显示文字
 @param color 字体颜色
 @param image 图片
 @param type  顺序
 @param rect  rect
 
 @return return value description
 */
+(NSMutableAttributedString*)ButtonAttriSring:(NSString *)title color:(UIColor*)color image:(NSString*)image type:(NSInteger)type rect:(CGRect)rect
{
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:image];
    // 设置图片大小
    attch.bounds =rect;
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:title];
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


+(NSMutableAttributedString*)AttributedString:(NSString*)title font:(UIFont*)font color:(UIColor*)color title1:(NSString*)title1  {
    
    
    NSString* str=[NSString stringWithFormat:@"%@%@",title,title1];
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:str];
    
    
    [attri addAttribute:NSForegroundColorAttributeName
     
                  value:color
     
                  range:NSMakeRange(0, title.length)];
    
    [attri addAttribute:NSFontAttributeName
     
                  value:font
     
                  range:NSMakeRange(0, title.length)];
    
    return attri;
    
}

+(LPlaceholderTextView*)addTextView:(CGRect)rect Tag:(NSInteger)tag  textColor:(UIColor*)color Alignment:(NSTextAlignment)alignment Text:(NSString*)textStr  placeholderStr:(NSString *)placeholderStr View:(UIView*)viewA font:(UIFont*)font{
    LPlaceholderTextView*textM=[[LPlaceholderTextView alloc] initWithFrame:rect];
    [textM setBackgroundColor:[UIColor clearColor]];
    [textM setTextColor:color];
    textM.tag=tag;
    [textM setFont:font];
    textM.placeholderText =placeholderStr;
    textM.text=textStr;
    textM.autocapitalizationType=UITextAutocapitalizationTypeNone;
    textM.textAlignment = alignment;
    [viewA addSubview:textM];
    
    return textM;
}


+(UIView *)addEmptyView:(CGRect)rect view:(UIView *)view1 title:(NSString*)title
{
    UIView *view=[[UIView alloc]init];
    view.frame=rect;
    view.userInteractionEnabled=NO;
    [view1 addSubview:view];
    
    
    UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0,0, view.frame.size.width,view.frame.size.height)];
    [view addSubview:labTitle];
   
    if([LSFEasy isEmpty:title]){
        
        labTitle.text=@"暂无数据";

    }else{
        
        labTitle.text=title;

    }

    labTitle.font=[UIFont systemFontOfSize:18.0];
    labTitle.textColor=[UIColor lightGrayColor];
    labTitle.textAlignment=1;
    
    return view;
}


+(void)donghuaView:(UIView*)view  Rect:(CGRect)rect{
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.5f];
    [view setFrame:rect];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    [UIView commitAnimations];
}

@end
