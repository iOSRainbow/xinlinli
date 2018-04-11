//
//  AddGoodViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGoodViewController : CommonViewController
{
    UIScrollView * scr;
    
    UITextField * usernameText,*iphoneText,*addressText,*numText;
   
}

@property(nonatomic,strong)NSString* gifId;
@end
