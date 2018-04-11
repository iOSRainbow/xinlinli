//
//  EvationViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvationViewController : CommonViewController
{
    LPlaceholderTextView * lptext;
    
    UIButton * btn1,*btn2,*btn3;
    
    
    NSString* state;
}
@property(nonatomic,strong)NSDictionary*Dic;
@end
