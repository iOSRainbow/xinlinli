//
//  MineViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "MineViewController.h"
#import "Mine_infoViewController.h"
#import "Mine_addressListViewController.h"
#import "Mine_accountListViewController.h"
#import "MineYiJianViewController.h"
#import "MineAboutViewController.h"
#import "Mine_RlistViewController.h"
#import "Mine_DuiHuanListViewController.h"
#import "OrderListViewController.h"
#import "FailViewController.h"
#import "DiscountListViewController.h"
#import "Mine_iphonViewController.h"
#import "GetAddressListViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController





-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
    Api * api =[[Api alloc] init:self tag:@"vip_vipuser"];
    [api vip_vipuser];
    
    Api * api1 =[[Api alloc] init:self tag:@"pointsCountByUserId"];
    [api1 pointsCountByUserId];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    navView.hidden=YES;
    
    
    dataArray=[[NSMutableArray alloc] initWithObjects:@"我的资料",@"收货地址管理",@"社区地址管理",@"抵用卷",@"抵用卷兑换",@"积分任务",@"礼品兑换", nil];

    imageArray=[[NSMutableArray alloc] initWithObjects:@"lsf19",@"lsf20",@"lsf39",@"lsf66",@"lsf101",@"lsf26",@"lsf25", nil];

    scr=[LSFUtil add_scollview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarStautsHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    
    UIImageView * img =[LSFUtil addSubviewImage:@"lsf18" rect:CGRectMake(0, 0, SCREEN_WIDTH, 240) View:scr Tag:1];
    
    headImgView=[LSFUtil addSubviewImage:nil rect:CGRectMake((SCREEN_WIDTH-60)/2, 65, 60, 60) View:img Tag:1];
    headImgView.layer.cornerRadius=30;
    headImgView.layer.masksToBounds=YES;
    
    
    nickNameLb=[LSFUtil labelName:@"Rainbow" fontSize:font14 rect:CGRectMake(0, 145, SCREEN_WIDTH, 20) View:img Alignment:1 Color:white Tag:1];
    
    UIView *viewAlah=[LSFUtil viewWithRect:CGRectMake(0,190, SCREEN_WIDTH, 50) view:img backgroundColor:black];
    viewAlah.alpha=0.2;
    
    
    NSArray * ary=[[NSArray alloc] initWithObjects:@"积分",@"签到",@"账户余额", nil];
    for(int i=0;i<ary.count;i++){
    
        [LSFUtil labelName:ary[i] fontSize:font14 rect:CGRectMake((SCREEN_WIDTH/3)*i, 195, SCREEN_WIDTH/3, 20) View:img Alignment:1 Color:white Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake((SCREEN_WIDTH/3)*i, 200, 1, 30) view:i==0?nil:img];
    }
    
    
    intergalLb=[LSFUtil labelName:@"(0)" fontSize:font14 rect:CGRectMake(0, 215, SCREEN_WIDTH/3, 20) View:img Alignment:1 Color:white Tag:1];
    
    signLb=[LSFUtil labelName:@"(0)" fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/3, 215, SCREEN_WIDTH/3, 20) View:img Alignment:1 Color:white Tag:1];

   signBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH/3, 190, SCREEN_WIDTH/3, 50) title:nil select:@selector(Action:) Tag:5 View:img textColor:nil Size:nil background:nil];
    
    collectLb=[LSFUtil labelName:@"(0)" fontSize:font14 rect:CGRectMake((SCREEN_WIDTH/3)*2, 215, SCREEN_WIDTH/3, 20) View:img Alignment:1 Color:white Tag:1];
    
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, 260, SCREEN_WIDTH, dataArray.count*50) Tag:1 View:scr delegate:self dataSource:self];
    tableview.scrollEnabled=NO;
    
    
    
    UIButton*loginOut=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 260+tableview.frame.size.height+20,SCREEN_WIDTH-40, 40) title:@"退出登录" select:@selector(Action:) Tag:1 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginOut.layer.cornerRadius=5;
    loginOut.layer.masksToBounds=YES;
    
    scr.contentSize=CGSizeMake(0, 330+tableview.frame.size.height);
}
-(void)Action:(UIButton*)btn{

    if(btn.tag==5){
    
        Api * api =[[Api alloc]init:self tag:@"sign"];
        [api sign];
    
    
    }else{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [myUserDefaults setObject:@"" forKey:@"token"];
        NSMutableArray * ary =[[NSMutableArray alloc] init];
        [myUserDefaults setObject:ary forKey:@"main_type"];
        
        [myUserDefaults synchronize];
        [[AppDelegate sharedAppDelegate] StartMain];
     
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    }
}

#pragma tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{

    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil addSubviewImage:nil rect:CGRectMake(10, 15, 20, 20) View:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(40, 0, SCREEN_WIDTH-50, 50) View:cell Alignment:0 Color:black Tag:2];
        
        UILabel*line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(40, 49, SCREEN_WIDTH, 1) view:cell];
        line.tag=3;
        
    }
    
  
    UIImageView * img =(UIImageView*)[cell viewWithTag:1];
    UILabel * lable =(UILabel*)[cell viewWithTag:2];
    UILabel *line =(UILabel*)[cell viewWithTag:3];
    
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[indexPath.row]]];
    
    lable.text=dataArray[indexPath.row];
    line.hidden=(indexPath.row==dataArray.count-1)?YES:NO;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0){
    
        Mine_infoViewController * info=[[Mine_infoViewController alloc] init];
        info.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:info animated:YES];
    
    }else if (indexPath.row==1){
        
        GetAddressListViewController * addressList =[[GetAddressListViewController alloc] init];
        addressList.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addressList animated:YES];
        
    }
    else if (indexPath.row==2){
    
        Mine_addressListViewController * addressList =[[Mine_addressListViewController alloc] init];
        addressList.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addressList animated:YES];
    }
    else if (indexPath.row==3){
        
        DiscountListViewController * addressList =[[DiscountListViewController alloc] init];
        addressList.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addressList animated:YES];
    }

    else if (indexPath.row==4){
    
        Mine_iphonViewController * vip =[[Mine_iphonViewController alloc] init];
        vip.hidesBottomBarWhenPushed=YES;
        vip.name=dataArray[indexPath.row];
        vip.completeBlockNone=^{};
        vip.viewType=1;
        [self.navigationController pushViewController:vip animated:YES];
    
    }
    else if(indexPath.row==5){
    
        Mine_RlistViewController * addressList =[[Mine_RlistViewController alloc] init];
        addressList.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:addressList animated:YES];
    
    }else if(indexPath.row==6){
    
        Mine_DuiHuanListViewController * addressList =[[Mine_DuiHuanListViewController alloc] init];
        addressList.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addressList animated:YES];
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
    if([tag isEqualToString:@"sign"]){
    
        [self showHint:response[@"msg"]];
        NSDictionary * dic=response[@"data"];

        signLb.text=[NSString stringWithFormat:@"(%@)",dic[@"isSign"]];
        intergalLb.text=[NSString stringWithFormat:@"(%@)",dic[@"points"]];
        signBtn.userInteractionEnabled=NO;
    }
    
   else if([tag isEqualToString:@"pointsCountByUserId"]){
    
        NSDictionary * dic=response[@"data"];
        
        nickNameLb.text=dic[@"realname"];
        
        [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"headpic"]]] placeholderImage:[UIImage imageNamed:@"lsf64"]];
       
        intergalLb.text=[NSString stringWithFormat:@"(%@)",dic[@"points"]];
        signBtn.userInteractionEnabled = [dic[@"isSign"] integerValue]==0?YES:NO;
        signLb.text=[NSString stringWithFormat:@"(%@)",dic[@"isSign"]];
        
       
        if(![dic[@"logtime"] isEqual:logtime]){
            
            
            UIAlertView * alret=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号已在其他手机登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alret show];
            [myUserDefaults setObject:@"" forKey:@"token"];
            [[AppDelegate sharedAppDelegate] StartMain];
        }
        
        [myUserDefaults synchronize];

   }else if ([tag isEqualToString:@"vip_vipuser"]){
       
       NSDictionary * dic=response[@"data"];

       collectLb.text=[NSString stringWithFormat:@"(%@)",dic[@"balance"]];
       
   }
 
}
@end
