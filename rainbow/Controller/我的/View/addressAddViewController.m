//
//  addressAddViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/2/27.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "addressAddViewController.h"

@interface addressAddViewController ()

@end

@implementation addressAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:[LSFEasy isEmpty:_Dict]?@"新增收货地址":@"修改收货地址"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 135) view:self.view backgroundColor:white];
    
    NSArray * ary=@[@"联系人",@"手机号",@"收货地址"];
    
    for(int i=0;i<ary.count;i++){
        
        [LSFUtil labelName:ary[i] fontSize:font14 rect:CGRectMake(10,45*i, 80, 45) View:view Alignment:0 Color:black Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 45*i, SCREEN_WIDTH, 1) view:i==0?nil:view];
    }
    
    nameText=[LSFUtil addTextFieldView:CGRectMake(90, 0, SCREEN_WIDTH-100, 45) Tag:1 textColor:black Alignment:0 Text:_Dict[@"name"] placeholderStr:@"请输入您的姓名" View:view font:font14];
    
    phoneText=[LSFUtil addTextFieldView:CGRectMake(90, 45, SCREEN_WIDTH-100, 45) Tag:1 textColor:black Alignment:0 Text:_Dict[@"tel"] placeholderStr:@"请输入您的手机号" View:view font:font14];

    addressText=[LSFUtil addTextFieldView:CGRectMake(90, 90, SCREEN_WIDTH-100, 45) Tag:1 textColor:black Alignment:0 Text:_Dict[@"address"] placeholderStr:@"请输入您的收货地址" View:view font:font14];
    
    
    
    UIButton * btn =[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(15,NavigationHeight+155, SCREEN_WIDTH-30, 35) title:@"提交" select:@selector(CommitAction) Tag:1 View:self.view textColor:white Size:font14 background:orange];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;

}

-(void)CommitAction{
    
    if(nameText.text.length==0){
        
        [self showHint:@"联系人不能为空"];
        return;
    }
    if(phoneText.text.length==0){
        
        [self showHint:@"手机号不能为空"];
        return;
    }
    if(![LSFEasy validateMobile:phoneText.text]){
        
        [self showHint:@"手机号格式不正确"];
        return;
    }
    if(addressText.text.length==0){
        
        [self showHint:@"收货地址不能为空"];
        return;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"address"];
    
    if([LSFEasy isEmpty:_Dict]){
        
        [api goodsaddress_add:nameText.text tel:phoneText.text address:addressText.text];

    }else{
        
        [api goodsaddress_edit:nameText.text tel:phoneText.text address:addressText.text addressId:[NSString stringWithFormat:@"%@",_Dict[@"id"]]];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    self.completeBlockNone();
    if([LSFEasy isEmpty:_Dict]){
        
        [self showHint:@"新增收货地址成功"];
    }else{
        
        [self showHint:@"修改收货地址成功"];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
