//
//  Mine_birthViewController.h
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_birthViewController : CommonViewController
{

    UILabel * birthLable;
    UIDatePicker * datePicker;


}
@property(strong ,nonatomic)  UIView*DatePickerView;

@property(nonatomic,strong)NSString * birthStr;
@end
