//
//  MyPoorViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/4.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "MyPoorViewController.h"
#import "PayDespositViewController.h"
#import "PayRentViewController.h"
#import "BatteryInfoViewController.h"
#import "BatteryRecordViewController.h"
#import "ScanViewController.h"
@interface MyPoorViewController ()

@end

@implementation MyPoorViewController


-(void)actNavRightBtn{
    
    ScanViewController * scan =[[ScanViewController alloc] init];
    scan.type=2;
    scan.year=year;
    [self.navigationController pushViewController:scan animated:YES];
}
-(void)actNavLeftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"我的电瓶"];
    navTitleLable.textColor=white;
    navView.backgroundColor=MS_RGB(106, 193, 60);
    navBackBtn.hidden=YES;
    [self addNavLeftBtnWithImage:@"battery_back" rect:CGRectMake(5, StatusHeight+7, 30, 30)];
    
    [self addNavRightBtnWithImage:@"battery_scanner" rect:CGRectMake(SCREEN_WIDTH-40,StatusHeight+12, 20, 20)];
    
    rent=@"0";
    deposit=@"0";
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight-1, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, ViewHeight)];
    
    [self createGroundbackView];
    [self createPoorInfoView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self getData];
}

-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"battery_getUserbatterybyUserId"];
    [api battery_getUserbatterybyUserId];
}

-(void)createGroundbackView{
    

    UIImageView * backgroundImg =[LSFUtil addSubviewImage:@"battery_background" rect:CGRectMake(0, 0,SCREEN_WIDTH, 160) View:scr Tag:1];
    
    headImg=[LSFUtil addSubviewImage:@"lsf64" rect:CGRectMake((SCREEN_WIDTH-60)/2, 50, 60, 60) View:backgroundImg Tag:1];
    headImg.layer.cornerRadius=30;
    headImg.layer.masksToBounds=YES;
}

-(void)createPoorInfoView{
    
    NSArray * imgArray =@[@"battery_deposit",@"battery_rent",@"battery_message",@"battery_exchange"];
    NSArray * titleArray=@[@" 我的押金：",@" 我的租金：",@" 设备信息",@" 更换记录"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 167, SCREEN_WIDTH, 200) view:scr backgroundColor:white];
    
    for(NSInteger i=0;i<imgArray.count;i++){
        
        UILabel * labTitle =[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 50*i, 120, 50) View:view Alignment:0 Color:black Tag:i];
        
        labTitle.attributedText=[LSFEasy ButtonAttriSring:titleArray[i] color:black image:imgArray[i] type:1 rect:CGRectMake(0, -5, 20, 20)];
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 50+50*i, SCREEN_WIDTH-10, 1) view:i==3?nil:view];
        
        
        UIButton*btn= [LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 50*i, SCREEN_WIDTH, 50) title:nil Tag:i View:view textColor:nil Size:nil];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    labdeposit=[LSFUtil labelName:@"" fontSize:font14 rect:CGRectMake(130, 0, SCREEN_WIDTH-140, 50) View:view Alignment:0 Color:Red Tag:1];
    
    labrent=[LSFUtil labelName:@"" fontSize:font14 rect:CGRectMake(130, 50, SCREEN_WIDTH-140, 50) View:view Alignment:0 Color:Red Tag:1];

}


-(void)action:(UIButton*)btn{
    

    NSInteger index =btn.tag;
    
    if(index==0){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否前去缴纳押金" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
             
            PayDespositViewController * pay =[[PayDespositViewController alloc] init];
            pay.deposit=self->deposit;
         
            [self.navigationController pushViewController:pay animated:YES];
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        
    }else if (index==1){
        
        if(deposit.floatValue==0){
            
            [self showHint:@"请先缴纳押金"];
            return;
        }
      
        if(used.integerValue==1&&year.integerValue>0){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否前去缴纳租金" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            PayRentViewController * pay =[[PayRentViewController alloc] init];
            
            pay.dict=@{@"parameter":self->parameter,@"year":self->year,@"rent":self->rent};
        
            [self.navigationController pushViewController:pay animated:YES];
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
        
    }else if (index==2){
        
        if([LSFEasy isEmpty:endDate]&&[LSFEasy isEmpty:startDate]){
            
            [self showHint:@"暂无设备信息"];
            return;
        }
        
        BatteryInfoViewController * info =[[BatteryInfoViewController alloc] init];
        
        info.dict=@{@"parameter":parameter,@"time":[NSString stringWithFormat:@"%@-%@",[self getTime:startDate],[self getTime:endDate]]};
        
        [self.navigationController pushViewController:info animated:YES];
        
    }else{
        
        BatteryRecordViewController * record =[[BatteryRecordViewController alloc] init];
        [self.navigationController pushViewController:record animated:YES];
        
    }
}


-(void)Failed:(NSString*)message tag:(NSString*)tag{
   
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag{
    
    [self hideHud];
    NSDictionary * dic=response[@"data"];
    
    NSString * picUrl= [NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"url"]];
    [headImg sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    deposit=dic[@"userbattery"][@"deposit"];
    rent=dic[@"userbattery"][@"rent"];
    
    labdeposit.text=[NSString stringWithFormat:@"￥%@",deposit];
    labrent.text=[NSString stringWithFormat:@"￥%@",rent];
    
    parameter=dic[@"parameter"];
    year=dic[@"year"];
    used=dic[@"used"];
    endDate=dic[@"userbattery"][@"end"];
    startDate=dic[@"userbattery"][@"start"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}
@end
