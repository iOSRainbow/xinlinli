//
//  WuYeWXViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuYeWXViewController : CommonViewController
{
    UIScrollView * scr,*picScr;
    
    UITextField * usernameText,*phoneText;
    
    UIButton * wybtn1,*wybtn2;
    
    LPlaceholderTextView * lpText;
    
    NSMutableArray *picArray;
    
    NSString * addressId,*typeId;


}
@end
