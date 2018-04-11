//
//  ModfiyBusViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/23.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "ModfiyBusViewController.h"

@interface ModfiyBusViewController ()

@end

@implementation ModfiyBusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"修改密码"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 150) view:self.view backgroundColor:white];
    
    pText1=[LSFUtil addTextFieldView:CGRectMake(10, 0, SCREEN_WIDTH-20, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"管理员密码(6位)" View:view font:font14];
    
    pText2=[LSFUtil addTextFieldView:CGRectMake(10, 50, SCREEN_WIDTH-20, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"使用密码(6位)" View:view font:font14];

    
    pText3=[LSFUtil addTextFieldView:CGRectMake(10, 100, SCREEN_WIDTH-20, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"使用密码(6位)" View:view font:font14];
    
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 250,SCREEN_WIDTH-40, 40) title:@"提交" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;

    
}
-(void)Action:(UIButton*)btn{

    if(pText1.text.length>6||pText1.text.length==0){
    
        [self showHint:@"管理员密码(6位)"];
        return;
    
    }
    if(pText2.text.length>6||pText2.text.length==0){
        
        [self showHint:@"使用密码(6位)"];
        return;
        
    }
    
    if(pText3.text.length>6||pText3.text.length==0){
        
        [self showHint:@"使用密码(6位)"];
        return;
        
    }
    if(![pText2.text isEqual:pText3.text]){
    
        [self showHint:@"使用密码2次输入不一致"];
        return;
    }
    
    
    [self showHint:@"发送修改使用密码指令"];
    
    //999999MB0123456
    NSData * data =[[NSString stringWithFormat:@"%@MB0%@",pText1.text,pText3.text] dataUsingEncoding:NSUTF8StringEncoding];
    [_modfiyBluetooth writeValue:_modfiyBluetooth.activePeripheral data:data];
    
    
    NSArray *array=[myUserDefaults objectForKey:@"data_bus"];
    NSMutableArray * ary=[[NSMutableArray alloc] init];
    if (array.count!=0) {
        ary=[array mutableCopy];
        
        [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(![obj[@"time"] isEqual:_dict[@"time"]]){
                
                [ary removeObjectAtIndex:idx];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
                NSString *date= [dateFormatter stringFromDate:[NSDate date]];
                NSDictionary * dic=@{@"name":_dict[@"name"],@"phone":UserName,@"time":date,@"password":pText3.text,@"info":_dict[@"info"]};
                
                [ary insertObject:dic atIndex:0];
                
                [myUserDefaults setObject: ary forKey:@"data_bus"];
                
                [myUserDefaults synchronize];
                
                self.completeBlockNSDictionary(dic);
                
                *stop=YES;
            }
            
        }];
        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)DataComeNotify:(NSData*)data{
    
    
    NSLog(@"data=====%@",data);
    
    NSString *string = [[NSString alloc]initWithFormat:@"%@",data.description];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string==nil)
    {
        return;
    }
    
    
    [self showHint:@"修改密码成功"];
    
    
}

-(void)DataFailNotify{
    
    [self showHint:@"修改密码失败,请检查管理员密码输入是否正确"];
    
}
@end
