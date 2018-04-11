//
//  Mine_add_addressViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_add_addressViewController.h"
#import "ProviceViewController.h"
#import "CiytViewController.h"
#import "AreaViewController.h"
#import "RoomViewController.h"
@interface Mine_add_addressViewController ()

@end

@implementation Mine_add_addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"添加地址信息"];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 250) view:self.view backgroundColor:white];
    
    for(int i=0;i<4;i++){
    
        [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30,50*i+15, 20, 20) View:view Tag:1];

        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50*i+50, SCREEN_WIDTH, 1) view:view];
    }
    
    
    
    proviceBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 0, SCREEN_WIDTH-50, 50) title:@"请选择您所在省" select:@selector(Action:) Tag:1 View:view textColor:black Size:font14 background:nil];
    proviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    cityBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 50, SCREEN_WIDTH-50, 50) title:@"请选择您所在城市" select:@selector(Action:) Tag:2 View:view textColor:black Size:font14 background:nil];
    cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    distrctBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 100, SCREEN_WIDTH-50, 50) title:@"请选择您所在区域" select:@selector(Action:) Tag:3 View:view textColor:black Size:font14 background:nil];
    distrctBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    houserBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 150, SCREEN_WIDTH-50, 50) title:@"请选择您所在小区" select:@selector(Action:) Tag:4 View:view textColor:black Size:font14 background:nil];
    houserBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [LSFUtil labelName:@"详细地址" fontSize:font14 rect:CGRectMake(10, 200, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    
    HText1=[LSFUtil addTextFieldView:CGRectMake(100, 210, 80, 30) Tag:1 textColor:black Alignment:1 Text:nil placeholderStr:nil View:view font:font14];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(100, 240, 80, 1) view:view];
    
    [LSFUtil labelName:@"栋" fontSize:font14 rect:CGRectMake(180, 210, 20, 30) View:view Alignment:0 Color:gray Tag:1];
    
    Htext2=[LSFUtil addTextFieldView:CGRectMake(200, 210, 80, 30) Tag:1 textColor:black Alignment:1 Text:nil placeholderStr:nil View:view font:font14];

    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(200, 240, 80, 1) view:view];
    
    [LSFUtil labelName:@"号" fontSize:font14 rect:CGRectMake(280, 210, 20, 30) View:view Alignment:0 Color:gray Tag:1];
    
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, NavigationHeight+280,SCREEN_WIDTH-40, 40) title:@"提交" select:@selector(Action:) Tag:5 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;


}

-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    
        ProviceViewController * p =[[ProviceViewController alloc] init];
        p.completeBlockNSDictionary=^(NSDictionary * dic){
        
            NSString * str =[NSString stringWithFormat:@"%@",dic[@"id"]];
            if(![str isEqual:proviceId]){
            
                [cityBtn setTitle:@"请选择您所在城市" forState:normal];
                [distrctBtn setTitle:@"请选择您所在区域" forState:normal];
                [houserBtn setTitle:@"请选择您所在小区" forState:normal];
                proviceId=str;
                [proviceBtn setTitle:dic[@"name"] forState:normal];
            }
            
        };
        [self.navigationController pushViewController:p animated:YES];
    
    
    }else if (btn.tag==2){
    
        if([proviceBtn.titleLabel.text isEqualToString:@"请选择您所在省"]){
        
            [self showHint:@"请先选择您所在省"];
            return;
        }
        
        CiytViewController * c =[[CiytViewController alloc] init];
        c.proviceId=proviceId;
        c.completeBlockNSDictionary=^(NSDictionary *dic){
        
            NSString * str =[NSString stringWithFormat:@"%@",dic[@"id"]];
            if(![str isEqual:cityId]){
                
                [distrctBtn setTitle:@"请选择您所在区域" forState:normal];
                [houserBtn setTitle:@"请选择您所在小区" forState:normal];
                cityId=str;
                [cityBtn setTitle:dic[@"name"] forState:normal];
            }
            
        };
        
        [self.navigationController pushViewController:c animated:YES];
    
    
    }else if (btn.tag==3){
    
        if([proviceBtn.titleLabel.text isEqualToString:@"请选择您所在省"]){
            
            [self showHint:@"请先选择您所在省"];
            return;
        }
        if([cityBtn.titleLabel.text isEqualToString:@"请选择您所在城市"]){
            
            [self showHint:@"请先选择您所在城市"];
            return;
        }
        
        AreaViewController * a =[[AreaViewController alloc] init];
        a.ciytId=cityId;
        a.completeBlockNSDictionary=^(NSDictionary *dic){
        
            NSString * str =[NSString stringWithFormat:@"%@",dic[@"id"]];
            if(![str isEqual:areaId]){
                
                [houserBtn setTitle:@"请选择您所在小区" forState:normal];
                areaId=str;
                [distrctBtn setTitle:dic[@"name"] forState:normal];
            }
        };
        
        [self.navigationController pushViewController:a animated:YES];
        
    
    }else if (btn.tag==4){
    
        if([proviceBtn.titleLabel.text isEqualToString:@"请选择您所在省"]){
            
            [self showHint:@"请先选择您所在省"];
            return;
        }
        if([cityBtn.titleLabel.text isEqualToString:@"请选择您所在城市"]){
            
            [self showHint:@"请先选择您所在城市"];
            return;
        }
        if([distrctBtn.titleLabel.text isEqualToString:@"请选择您所在区域"]){
            
            [self showHint:@"请先选择您所在区域"];
            return;
        }
        
        RoomViewController * r =[[RoomViewController alloc] init];
        r.areaId=areaId;
        r.completeBlockNSDictionary=^(NSDictionary*dic){
        
            NSString * str =[NSString stringWithFormat:@"%@",dic[@"id"]];
            if(![str isEqual:roomId]){
                
                roomId=str;
                [houserBtn setTitle:dic[@"name"] forState:normal];
            }
        };
        [self.navigationController pushViewController:r animated:YES];
    
    }else{
    
    
        
        if([proviceBtn.titleLabel.text isEqualToString:@"请选择您所在省"]){
            
            [self showHint:@"请选择您所在省"];
            return;
        }
        if([cityBtn.titleLabel.text isEqualToString:@"请选择您所在城市"]){
            
            [self showHint:@"请选择您所在城市"];
            return;
        }
        if([distrctBtn.titleLabel.text isEqualToString:@"请选择您所在区域"]){
            
            [self showHint:@"请选择您所在区域"];
            return;
        }
        if([houserBtn.titleLabel.text isEqualToString:@"请选择您所在小区"]){
            
            [self showHint:@"请选择您所在小区"];
            return;
        }
        
        if(HText1.text.length==0){
        
        
            [self showHint:@"xx栋不能为空"];
            return;
        
        }
        if(Htext2.text.length==0){
        
            [self showHint:@"xx号不能为空"];
            return;
        }
    
        [self showHudInView:self.view hint:@"加载中"];
        
        Api * api =[[Api alloc] init:self tag:@"insertAddressWithUserId"];
        [api insertAddressWithUserId:roomId buildingname:HText1.text roomname:Htext2.text];
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    [self showHint:response[@"msg"]];
    self.completeBlockNone();
    [self.navigationController popViewControllerAnimated:YES];
}


@end
