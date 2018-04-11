//
//  SignViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignViewController : CommonViewController
{

    UIScrollView * scr;
    
    UITextField * usernameText,*valiteText,*passwordText,*aginpassword;
    
    UIButton * valiteBtn;
    
    NSTimer * timer;
    NSInteger _timestamp;
    
}

@property(nonatomic,assign)NSInteger viewType;
@end
