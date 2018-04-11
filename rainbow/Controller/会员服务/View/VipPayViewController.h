//
//  VipPayViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipPayViewController : CommonViewController
{
    UITextField * text,*money;
    
    UIView * payview;
    
    NSMutableArray * dataArray,*gouArray;
    
    NSInteger Tag;
    

}
@end
