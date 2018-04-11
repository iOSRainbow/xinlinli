//
//  Mine_iphonViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_iphonViewController : CommonViewController
{
    UITextField * usernameText,*valiteText;

}
@property(nonatomic,strong)NSString*name;
@property(nonatomic,assign)NSInteger viewType;

@end
