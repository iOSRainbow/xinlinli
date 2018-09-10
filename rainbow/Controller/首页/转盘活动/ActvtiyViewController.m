//
//  ActvtiyViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/1/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ActvtiyViewController.h"


#define Rate 229/660
#define TopBannerHeight SCREEN_WIDTH*Rate


#define Rate1 115/294
#define bottomHeight SCREEN_WIDTH*Rate1

@interface ActvtiyViewController ()

@end

@implementation ActvtiyViewController

-(void)actNavRightBtn{
    
    if([navRightBtn.titleLabel.text isEqualToString:@"未领取"]){
        
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否确认领取奖品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self stopTimer];
            [self showHudInView:self.view hint:@"加载中"];
            Api * api =[[Api alloc] init:self tag:@"app_prizes_receivePrizesData"];
            [api app_prizes_receivePrizesData];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"文化节"];
    [self addNavRightBtnWithTitle:nil color:Red];
    
    timerTag=0;
    dataArray=@[@{@"pic":@"300抵用卷",@"name":@"壁挂式空调清洗券"},@{@"pic":@"300抵用卷",@"name":@"30元充电电费券"},@{@"pic":@"300抵用卷",@"name":@"30元共享电瓶安装券"},@{@"pic":@"300抵用卷",@"name":@"30元充电电费券"},@{@"pic":@"300抵用卷",@"name":@"30元共享电瓶安装券"},@{@"pic":@"300抵用卷",@"name":@"壁挂式空调清洗券"}];
    gouArray=[[NSMutableArray alloc] init];
    
    for(int i=0;i<dataArray.count;i++){
        
        [gouArray addObject:@"0"];
    }
    
    
    scr=[LSFUtil add_scollview:CGRectMake(0,NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0,ViewHeight)];
    scr.backgroundColor=MS_RGB(231, 65, 67);
    
    [LSFUtil addSubviewImage:@"文字特" rect:CGRectMake(0,5,SCREEN_WIDTH,TopBannerHeight) View:scr Tag:1];
    
    [self initCollectionView:TopBannerHeight+25];
    
    
    [self getData];
    

}
-(void)actNavBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initCollectionView:(CGFloat)hy{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(10, hy, SCREEN_WIDTH-20, 220+101/2.5) view:scr backgroundColor:MS_RGB(254, 242, 203)];
    view.layer.cornerRadius=5;
    view.layer.masksToBounds=YES;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //创建一个UICollectionView对象
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, view.frame.size.width,190) collectionViewLayout:flowLayout];
    collectionView.backgroundColor=MS_RGB(254, 242, 203);
    //指定数据源代理
    collectionView.dataSource = self;
    collectionView.scrollEnabled=NO;
    //注册Cell
    [collectionView registerClass:[ActvityCell  class] forCellWithReuseIdentifier:@"item"];
    collectionView.alwaysBounceVertical = YES;
    //设置业务代理
    collectionView.delegate = self;
    [view addSubview:collectionView];
    
    
    startBtn=[LSFUtil buttonPhotoAlignment:@"3" hilPhoto:@"3" rect:CGRectMake((view.frame.size.width-381/2.5)/2, 210, 381/2.5, 101/2.5) title:nil Tag:1 View:view textColor:nil Size:nil];
    [startBtn addTarget:self action:@selector(StartActivity) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self allocZhongJiangView:view.frame.size.height+view.frame.origin.y+20];
    
}

-(void)startActivtyTimer{
    
    actvityTimer =[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(reloadCollection) userInfo:nil repeats:YES];
}
-(void)stopActivtyTimer{
    
    [actvityTimer invalidate];
     actvityTimer=nil;
}
-(void)reloadCollection{
    
    timerTag++;
    
    if(timerTag<=6){
        
        tag=timerTag-1;
    }
    else if (timerTag<=12){
        
        tag=timerTag-7;
    }
    else if (timerTag<=18){
        
        tag=timerTag-13;
    }
 
    [self reloadData];

    
    if(timerTag==endTimerTag){
        
        
        [self stopActivtyTimer];
        
        startBtn.enabled=YES;
        
        [self startTimer];
        NSString * str =@"恭喜您抽中";
        jpLable.attributedText=[self UILableAttriSring:Red title1:str title2:prizesname];
        
        [navRightBtn setTitle:@"未领取" forState:normal];
        
        
        UIAlertView * alret =[[UIAlertView alloc] initWithTitle:@"中奖啦" message:[NSString stringWithFormat:@"%@ %@",str,prizesname] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alret show];
    }
 
}

-(void)reloadData{
    
    [gouArray removeAllObjects];
    
    for(int i=0;i<dataArray.count;i++){
        
        if(i==tag){
            
            [gouArray addObject:@"1"];
        }else{
            
            [gouArray addObject:@"0"];
        }
    }
    
    [collectionView reloadData];
}

-(void)StartActivity{
    
    
    if(result==1){

        [self showHint:@"您已参与过此抽奖！"];
        return;
    }
    
     [self stopTimer];
     [self stopActivtyTimer];
     startBtn.enabled=NO;
    timerTag=0;
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"app_prizes_setPrizesData"];
    [api app_prizes_setPrizesData];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self startTimer];

}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self stopTimer];

}
-(void)startTimer{
    
    [self stopTimer];
    
    timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getData) userInfo:nil repeats:YES];

}
-(void)stopTimer{
    
    [timer invalidate];
    timer=nil;
}

-(void)getData{
    
    Api * api =[[Api alloc] init:self tag:@"app_prizes_getPrizesData"];
    [api app_prizes_getPrizesData];
}

-(void)allocZhongJiangView:(CGFloat)hy{
    
    [LSFUtil addSubviewImage:@"lsf105" rect:CGRectMake(20,hy,57/2,71/2) View:scr Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf105" rect:CGRectMake(SCREEN_WIDTH-20-57/2,hy,57/2,71/2) View:scr Tag:1];
    
    UIImageView * img1=[LSFUtil addSubviewImage:@"lsf106" rect:CGRectMake(20,hy+71/2,SCREEN_WIDTH-40,38) View:scr Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf104" rect:CGRectMake(15,(38-27/2)/2,35/2,27/2) View:img1 Tag:1];
    
    jpLable=[LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(40,4, img1.frame.size.width-50, 30) View:img1 Alignment:0 Color:black Tag:2];
    
    [self allocTableView:img1.frame.size.height+img1.frame.origin.y+20];
}

-(void)allocTableView:(CGFloat)hy{
    
    tableview=[LSFUtil add_tableview:CGRectMake(20, hy+15, SCREEN_WIDTH-40, 210) Tag:1 View:scr delegate:self dataSource:self];
    tableview.layer.cornerRadius=4;
    tableview.layer.masksToBounds = YES;
    tableview.layer.borderColor =MS_RGB(251, 160, 113).CGColor;
    tableview.layer.borderWidth=5;
    tableview.backgroundColor=MS_RGB(249,247, 217);
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(20, 0, SCREEN_WIDTH-40, 67/2) view:nil backgroundColor:MS_RGB(243, 238, 196)];
    
    [LSFUtil addSubviewImage:@"lsf112" rect:CGRectMake((view.frame.size.width-330/2)/2,0, 330/2, 67/2) View:view Tag:1];
    
    tableview.tableHeaderView=view;
    
   
    [self allocBotoomView:tableview.frame.size.height+tableview.frame.origin.y+30];
}

-(void)allocBotoomView:(CGFloat)hy{
    
    //706 × 360
    [LSFUtil addSubviewImage:@"文字特2" rect:CGRectMake((SCREEN_WIDTH-294/2)/2,hy, 294/2, 115/2) View:scr Tag:1];
    
    scr.contentSize=CGSizeMake(0, hy+65+TabbarStautsHeight);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    
    
    if([tag isEqualToString:@"app_prizes_getPrizesData"]){
   
        NSDictionary * dic=response[@"data"];
        NSDictionary * json =dic[@"nineUserPrizeCustom"];

        result =[dic[@"result"] integerValue];
        status =[json[@"status"] integerValue];

        if(result==0){
            
            [jpLable setAttributedText:nil];
            jpLable.text=@"您还未抽奖";
            [navRightBtn setTitle:@"未抽奖" forState:normal];
        }
        else{
            
            jpLable.text=nil;
            NSString * str =@"恭喜您抽中";
            NSString * str2=json[@"prizesname"];
            [jpLable setAttributedText:[self UILableAttriSring:Red title1:str title2:str2]];
            
            [navRightBtn setTitle:status==0?@"未领取":@"已领取" forState:normal];
        }
        
        prizesrecordCustoms=dic[@"nineUserPrizeCustoms"];
        [tableview reloadData];
      
    }
    if([tag isEqualToString:@"app_prizes_setPrizesData"]){
   
        prizesrecordCustoms=response[@"data"][@"nineUserPrizeCustoms"];
        [tableview reloadData];
        
        result =[response[@"data"][@"result"] integerValue];
        
        NSDictionary * dic=response[@"data"][@"nineUserPrizeCustom"];
        username=dic[@"username"];
        prizesname=dic[@"prizesname"];

        __block NSInteger index =0;
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if([self->prizesname isEqualToString:dict[@"name"]]){
                
                index=idx;
                *stop=YES;
            }
            
        }];
        
        
        endTimerTag =13+index;
        
        [self startActivtyTimer];
    }
    if([tag isEqualToString:@"app_prizes_receivePrizesData"]){
        
        [navRightBtn setTitle:@"已领取" forState:normal];
        [self startTimer];

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return prizesrecordCustoms.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.backgroundColor=indexPath.row%2==0?MS_RGB(249,247, 217):MS_RGB(243, 238, 196);
        
        [LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(0, 0,100,30) View:cell Alignment:1 Color:gray Tag:1];
        
        [LSFUtil labelName:@"抽中" fontSize:font13 rect:CGRectMake(105, 0,40,30) View:cell Alignment:1 Color:gray Tag:2];
        
        [LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(140, 0,tableview.frame.size.width-145,30) View:cell Alignment:1 Color:Red Tag:3];
    }
    
    UILabel * username =(UILabel*)[cell viewWithTag:1];
    UILabel * prizesname =(UILabel*)[cell viewWithTag:3];
    
    NSDictionary * dic=prizesrecordCustoms[indexPath.row];
    
    NSString * name =dic[@"username"];
    
    username.text=[NSString stringWithFormat:@"%@***%@",[name substringToIndex:3],[name substringFromIndex:name.length-3]];
    prizesname.text=dic[@"prizesname"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}
-(NSMutableAttributedString*)UILableAttriSring:(UIColor*)color title1:(NSString*)title1 title2:(NSString*)title2
{
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",title1,title2]];
    
    [attri addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(title1.length,title2.length)];
    
    return  attri;
    
}


#pragma collectionview
//返回每个分区Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}
//返回collectionView分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//根据indexPath 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ActvityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    NSDictionary * dic =[dataArray objectAtIndex:indexPath.row];
    
    cell.pic.image=[UIImage imageNamed:dic[@"pic"]];
    cell.labName.text=dic[@"name"];
    NSInteger a =[gouArray[indexPath.row] integerValue];
    
    
    
    if(a==1){
        
        cell.pic.layer.borderWidth=1;
        cell.pic.layer.borderColor=Red.CGColor;
        cell.labName.textColor=Red;
    }
    else{
        
        cell.pic.layer.borderWidth=0;
        cell.pic.layer.borderColor=[UIColor clearColor].CGColor;
        cell.labName.textColor=black;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger collectWidth=(SCREEN_WIDTH-20-(3+1)*5)/3;

    return CGSizeMake(collectWidth,90);
}
//返回分区缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5,5,0,5);
    
}

//返回每一行item之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
    
}
//返回item之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



@end
