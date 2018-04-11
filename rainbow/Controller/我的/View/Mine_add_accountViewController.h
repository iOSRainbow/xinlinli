//
//  Mine_add_accountViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_add_accountViewController : CommonViewController

{

    UITextField * usernameText,*passwordText,*valiteText;
    UIButton * valiteBtn;
    NSTimer * timer;
    NSInteger _timestamp;

}


@end
