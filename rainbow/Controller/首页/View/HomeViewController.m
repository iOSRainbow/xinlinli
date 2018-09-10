//
//  HomeViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "HomeViewController.h"
#import "GBTopLineView.h"
#import "GBTopLineViewModel.h"
#import "Mine_DuiHuanListViewController.h"
#import "WuYeTipViewController.h"
#import "WuYeWXViewController.h"
#import "FriendListViewController.h"
#import "FailViewController.h"
#import "BusLockViewController.h"
#import "WuYeJiaoFeiViewController.h"
#import "JiaoFeiViewController.h"
#import "OpeationBusViewController.h"
#import "MoreTypeViewController.h"
#import "JZListViewController.h"
#import "JZTypeListViewController.h"
#import "JZDetailViewController.h"
#import "RuleViewController.h"
#import "MyPoorViewController.h"
#import "ActvtiyViewController.h"
#define Rate 280/640
#define TopScrollHeigt SCREEN_WIDTH*Rate
@interface HomeViewController ()

@end

@implementation HomeViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //
    Api * api =[[Api alloc] init:self tag:@"app_user_getTime"];
    [api app_user_getTime];
    
}

-(void)getMainData{

   
    NSArray *array=[myUserDefaults objectForKey:@"main_type"];
    
    if (array.count!=0) {
        dataArray=[array mutableCopy];
    }
    else{
    NSArray * ary =[[NSArray alloc] initWithObjects:@"我的电瓶",@"车位锁",@"居家服务",@"室内环保",@"家政服务",@"家电清洗",@"邻里圈",@"更多分类", nil];
    NSArray * ary1=@[@"icon_battery",@"lsf92",@"lsf49",@"lsf96",@"lsf97",@"lsf98",@"lsf52",@"lsf74"];
    for(int i=0;i<ary.count;i++){
        
        NSDictionary * dic=@{@"name":ary[i],@"pic":ary1[i]};
        [dataArray addObject:dic];
    }
        
    [myUserDefaults setObject: dataArray forKey:@"main_type"];
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    navView.hidden=YES;
    dataArray=[[NSMutableArray alloc] init];

    
    [self getMainData];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarStautsHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    Api * indexphoto=[[Api alloc] init:self tag:@"indexPhoto_banner"];
    [indexphoto indexPhoto_banner];
    
    Api * adminInfo=[[Api alloc] init:self tag:@"adminInfo"];
    [adminInfo adminInfo];
    
    [self allocMenuClassView];
   

}
-(void)alloclableScrViewClass:(NSMutableArray *)ary
{
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, TopScrollHeigt, SCREEN_WIDTH, 40) view:scr backgroundColor:white];
    
    UILabel * lb =[LSFUtil labelName:@"通知" fontSize:font12 rect:CGRectMake(10, 10, 30, 20) View:view Alignment:1 Color:white Tag:1];
    lb.backgroundColor=MS_RGB(39, 172, 57);
    lb.layer.cornerRadius=5;
    lb.layer.masksToBounds=YES;
    
    if(ary.count==0){
    
        
        [LSFUtil labelName:@"暂无通知" fontSize:font14 rect:CGRectMake(50, 10, 200, 20) View:view Alignment:0 Color:black Tag:1];
        return;
    
    }
    
    GBTopLineView *_TopLineView = [[GBTopLineView alloc]initWithFrame:CGRectMake(50, 0,SCREEN_WIDTH-55, 40)];
    _TopLineView.backgroundColor = [UIColor whiteColor];
        
    _TopLineView.clickBlock = ^(NSInteger index){
            
            //[self GBTopLineViewClick:index];
    };
        
    NSMutableArray * hotArray =[[NSMutableArray alloc] init];
    for (NSDictionary *dict in ary) {
            GBTopLineViewModel *model = [[GBTopLineViewModel alloc]init];
            model.title = dict[@"content"];
            [hotArray addObject:model];
    }
    [_TopLineView setVerticalShowDataArr:hotArray];
        
    [view addSubview:_TopLineView];
    

}

-(void)allocMenuClassView;
{
    
    CGFloat hy=100;
    
    if(dataArray.count>4){
       
        if(dataArray.count%4==0){
        
            hy=(dataArray.count/4)*100;
        }
        else{
        
            hy=((dataArray.count/4)+1)*100;

        }
    }
    
    [mainView removeFromSuperview];
    mainView =[LSFUtil viewWithRect:CGRectMake(0, 40+TopScrollHeigt, SCREEN_WIDTH, hy) view:scr backgroundColor:white];
    
    
    for(int i=0;i<dataArray.count;i++){
        
        NSInteger index = i%4;
        NSInteger page = i/4;
        NSDictionary * dic=dataArray[i];
        
        @autoreleasepool {
            
        UIView * view=[LSFUtil viewWithRect:CGRectMake(index*(SCREEN_WIDTH/4), page*100, SCREEN_WIDTH/4, 100) view:mainView backgroundColor:nil];
        
        [LSFUtil addSubviewImage:[NSString stringWithFormat:@"%@",dic[@"pic"]] rect:CGRectMake((view.frame.size.width-50)/2, 10, 50, 50) View:view Tag:1];
        
        [LSFUtil labelName:dic[@"name"] fontSize:font14 rect:CGRectMake(0, 70, view.frame.size.width, 20) View:view Alignment:1 Color:black Tag:1];
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, 100) title:nil select:@selector(Action:) Tag:i View:view textColor:nil Size:nil background:nil];
    }
        
}
 
    
    height=hy+40+TopScrollHeigt;
   
    
    [self initTableView];

    Api * list =[[Api alloc] init:self tag:@"app_goods_loglist"];
    [list app_goods_loglist];
    
}

-(void)initTableView{

  
    [tableview removeFromSuperview];
    tableview=[LSFUtil add_tableview:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT) Tag:1 View:scr delegate:self dataSource:self];
    tableview.scrollEnabled=NO;
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 150) view:nil backgroundColor:white];
    
    NSArray * goodPicAry=@[@"lsf99",@"lsf100"];
    NSArray * goodNameAry=@[@"专业的家电清洗",@"放心的家政服务"];
    NSArray * goodContentAry=@[@"给家电做最专业的SPA，让家电焕然一新！",@"家庭琐事别担心，私人管家来帮您！"];
    for(int i=0;i<goodPicAry.count;i++){
    
        @autoreleasepool {
           
            [LSFUtil addSubviewImage:goodPicAry[i] rect:CGRectMake(10, 7.5+75*i, 60, 60) View:view Tag:1];
            [LSFUtil labelName:goodNameAry[i] fontSize:font14 rect:CGRectMake(80, 15+75*i, view.frame.size.width-85, 20) View:view Alignment:0 Color:black Tag:2];
            [LSFUtil labelName:goodContentAry[i] fontSize:font14 rect:CGRectMake(80, 40+75*i, view.frame.size.width-85, 20) View:view Alignment:0 Color:black Tag:3];
            [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 75+75*i, SCREEN_WIDTH, 1) view:view];
            [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0,75*i, view.frame.size.width, 75) title:nil select:@selector(GoodAction:) Tag:i View:view textColor:nil Size:nil background:nil];

        }
    }
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 0, SCREEN_WIDTH, 1) view:view];

    tableview.tableHeaderView=view;
}

-(void)GoodAction:(UIButton*)btn{

    if(btn.tag==0){
    
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=@"家电清洗";
        list.type=@"a0976e80-7f69-4c58-aafe-2ffd939dabbc";
        [self.navigationController pushViewController:list animated:YES];
    }else{
    
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=@"家政服务";
        list.type=@"05e175b7-ce3b-464d-9015-5e07f8dd0da2";
        [self.navigationController pushViewController:list animated:YES];
    
    }


}
-(void)Action:(UIButton *)btn{

    NSDictionary * dic =dataArray[btn.tag];
    NSString * str =dic[@"name"];
    if ([str isEqualToString:@"物业公告"]){
    
        WuYeTipViewController * list =[[WuYeTipViewController alloc] init];
        
        list.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:list animated:YES];
    
    }
    else if ([str isEqualToString:@"物业维修"]){
        
        
        WuYeWXViewController * list =[[WuYeWXViewController alloc] init];
        
        list.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:list animated:YES];
    }
     else if ([str isEqualToString:@"邻里圈"]){
        
        FriendListViewController * list =[[FriendListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
        
    }else if ([str isEqualToString:@"礼品兑换"]){
        
        Mine_DuiHuanListViewController * list =[[Mine_DuiHuanListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([str isEqualToString:@"车位锁"]){
    
        OpeationBusViewController * fail =[[OpeationBusViewController alloc] init];
        fail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:fail animated:YES];
    }
    else if ([str isEqualToString:@"居家服务"]){

        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=str;
        list.type=@"bc492fc4-3060-4ad8-aaaf-87c837ffefda";
        [self.navigationController pushViewController:list animated:YES];
    }
    else if([str isEqualToString:@"室内环保"]){
        
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=str;
        list.type=@"78cd6aea-842d-4bd1-a3c1-040f6e15493a";
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([str isEqualToString:@"家电清洗"]){
    
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=str;
        list.type=@"a0976e80-7f69-4c58-aafe-2ffd939dabbc";
        [self.navigationController pushViewController:list animated:YES];
        
    }else if ([str isEqualToString:@"家政服务"]){
    
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=str;
        list.type=@"05e175b7-ce3b-464d-9015-5e07f8dd0da2";
        [self.navigationController pushViewController:list animated:YES];
    }
    else if([str isEqualToString:@"更多分类"]){
    
        MoreTypeViewController * list =[[MoreTypeViewController alloc] init];
        
        __weak typeof(self) weakSelf=self;
        list.completeBlockMutableArray=^(NSMutableArray *ary){
        
            self->dataArray=ary;
            [myUserDefaults setObject:self->dataArray forKey:@"main_type"];
            [myUserDefaults synchronize];
            [weakSelf allocMenuClassView];
        };
        list.dicAray=dataArray;
        
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
    
    }else if ([str isEqualToString:@"我的电瓶"]){
        
     
        MyPoorViewController * poor =[[MyPoorViewController alloc] init];
        poor.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:poor animated:YES];
        
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
    
    if([tag isEqualToString:@"indexPhoto_banner"]){
    
        bannerAry =response[@"data"];
        NSMutableArray * bannerPicArray=[[NSMutableArray alloc] init];
        
        for (NSDictionary *item in bannerAry) {
            NSString *picUrl=[item objectForKey:@"indexphoto"];
            [bannerPicArray addObject:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=a",urlStr,picUrl]];
        }
        
       
        FFScrollView* ffScr=[[FFScrollView alloc]initPageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,TopScrollHeigt) views:bannerPicArray tag:@"home"];
        ffScr.pageViewDelegate=self;
        [scr addSubview:ffScr];
        
    }
    
    if([tag isEqualToString:@"adminInfo"]){
    
        NSMutableArray * ary =response[@"data"];
        [self alloclableScrViewClass:ary];
    
    }
    if([tag isEqualToString:@"app_user_getTime"]){
    
        NSDictionary * dic=response[@"data"];
        if(![dic[@"logtime"] isEqual:logtime]){
            
            
            UIAlertView * alret=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号已在其他手机登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alret show];
            [myUserDefaults setObject:@"" forKey:@"token"];
            [myUserDefaults synchronize];
            [[AppDelegate sharedAppDelegate] StartMain];
        }
    
    }
    if([tag isEqualToString:@"app_goods_loglist"]){
    
        NSLog(@"%@",response);
        [goodsArray removeAllObjects];
        if([LSFEasy isEmpty:response[@"data"]]){
        
            return;
        }
        goodsArray=response[@"data"];
        [tableview reloadData];
        tableview.frame=CGRectMake(0, height, SCREEN_WIDTH,150+75*goodsArray.count);
        scr.contentSize=CGSizeMake(0, height+tableview.frame.size.height);
    
    }
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    return 75;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return goodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        [LSFUtil addSubviewImage:nil rect:CGRectMake(10, 7.5, 60, 60) View:cell Tag:1];
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(80, 15, SCREEN_WIDTH-85, 20) View:cell Alignment:0 Color:black Tag:2];
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(80, 40, SCREEN_WIDTH-85, 20) View:cell Alignment:0 Color:black Tag:3];
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 74, SCREEN_WIDTH, 1) view:cell];

    }
    
    UIImageView * goodPic=(UIImageView*)[cell viewWithTag:1];
    UILabel * goodName=(UILabel*)[cell viewWithTag:2];
    UILabel * goodContent=(UILabel*)[cell viewWithTag:3];
    
    NSDictionary * dic=goodsArray[indexPath.row];
    
    
    NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
    
    [goodPic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    goodName.text=dic[@"name"];
    goodContent.text=dic[@"detail"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * dic=goodsArray[indexPath.row];
    JZDetailViewController * detail =[[JZDetailViewController alloc] init];
    detail.hidesBottomBarWhenPushed=YES;
    detail.goodsId=dic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)scrollViewDidClickedAtPage:(NSInteger)pageNumber{

    NSDictionary * dic =bannerAry[pageNumber];
    NSString * href =dic[@"href"];
    
    if([href isEqualToString:@"居家服务"]){
    
        
        JZTypeListViewController * list =[[JZTypeListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        list.name=@"家电清洗";
        list.type=@"a0976e80-7f69-4c58-aafe-2ffd939dabbc";
        [self.navigationController pushViewController:list animated:YES];
    
    }else if ([href isEqualToString:@"积分兑换"]){
    
        Mine_DuiHuanListViewController * list =[[Mine_DuiHuanListViewController alloc] init];
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
        
    
    }else{
    
        if(![LSFEasy isEmpty:href]){
            
            ActvtiyViewController * list =[[ActvtiyViewController alloc] init];
            list.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:list animated:YES];
            
//            RuleViewController * list =[[RuleViewController alloc] init];
//            list.hidesBottomBarWhenPushed=YES;
//            list.webUrl=[NSString stringWithFormat:@"%@&userId=%@",href,TOKEN];
//            [self.navigationController pushViewController:list animated:YES];
            
        }
    }
}

@end
