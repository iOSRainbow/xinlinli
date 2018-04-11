//
//  Mine_add_addressViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_add_addressViewController : CommonViewController
{
    UIButton * proviceBtn,*cityBtn,*distrctBtn,*houserBtn;
    
    UITextField * HText1,*Htext2;

    NSString *proviceId,*cityId,*areaId,*roomId;

}

@end
