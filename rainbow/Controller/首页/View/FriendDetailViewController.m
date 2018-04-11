//
//  FriendDetailViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController ()

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"邻里圈详情"];
    
    
    itemDic=[[NSDictionary alloc] init];
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0,NavigationHeight,SCREEN_WIDTH,ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];

    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"topic_findPriById"];
    [api topic_findPriById:_friendModel.friendId];
    
}

-(void)MainViewClass{

    CGFloat hy =[LSFEasy getLabHeight:itemDic[@"content"] FontSize:font14 Width:SCREEN_WIDTH-20]+10;

    NSMutableArray * picArray=itemDic[@"topicphotos"];
    
    CGFloat hy1=0;
    
    if(picArray.count==0){
        
        hy1=0;
        
    }else{
        
       hy1=(picArray.count<=3)?90:180;
    }
    
    UIView * cell =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 130+hy1+hy) view:nil backgroundColor:white];
    
    
    UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake(10, 10, 50, 50) View:cell Tag:1];
    img.layer.cornerRadius=25;
    img.layer.masksToBounds=YES;
    [img sd_setImageWithURL:[NSURL URLWithString:_friendModel.headPicUrl] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    
    [LSFUtil labelName:itemDic[@"user"][@"realname"] fontSize:font14 rect:CGRectMake(70, 10, SCREEN_WIDTH-90, 50) View:cell Alignment:0 Color:black Tag:2];
    
    [LSFUtil labelName:[self getTime:itemDic[@"date"]] fontSize:font14 rect:CGRectMake(0,10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:5];
    
    [LSFUtil labelName:itemDic[@"content"] fontSize:font14 rect:CGRectMake(10, 70, SCREEN_WIDTH-20, hy) View:cell Alignment:0 Color:gray Tag:3];

    UIView *imgView=[LSFUtil viewWithRect:CGRectMake(10, hy+70, SCREEN_WIDTH-20, hy1) view:picArray.count==0?nil:cell backgroundColor:nil];
    
    for(int i=0;i<picArray.count;i++){
        
        NSInteger index=i%3;
        NSInteger page=i/3;
        
        NSDictionary * dic=picArray[i];
        
        UIView * view =[LSFUtil viewWithRect:CGRectMake((imgView.frame.size.width/3)*index, 90*page,imgView.frame.size.width/3, 90) view:imgView backgroundColor:nil];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=i",urlStr,dic[@"photourl"]];
        
        UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake((view.frame.size.width-80)/2,5, 80, 80) View:view Tag:1];
        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
    }
    
    UILabel * lb4=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 80+hy+hy1, SCREEN_WIDTH/2, 20) View:cell Alignment:0 Color:gray Tag:6];
    [lb4 setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",itemDic[@"cell"][@"name"]] color:gray image:@"lsf63" type:1 rect:CGRectMake(0, -4, 20, 20)]];
    
    
     pinglunLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/4+SCREEN_WIDTH/2, hy+80+hy1, SCREEN_WIDTH/4-10, 20) View:cell Alignment:2 Color:gray Tag:7];
    
    [pinglunLb setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",itemDic[@"reLength"]] color:gray image:@"lsf61" type:1 rect:CGRectMake(0, -5, 18, 18)]];
    
    pinglunLb.userInteractionEnabled=YES;
    
    
    
   [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, pinglunLb.frame.size.width, 20) title:nil select:@selector(Action:) Tag:1 View:pinglunLb textColor:nil Size:nil background:nil];
    
    
    
    dianzanLb= [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/2, hy1+80+hy, SCREEN_WIDTH/4-10, 20) View:cell Alignment:2 Color:gray Tag:8];
    
    [dianzanLb setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",itemDic[@"praise"]] color:gray image:@"lsf62" type:1 rect:CGRectMake(0, -5, 18, 18)]];
    
    dianzanLb.userInteractionEnabled=YES;
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, dianzanLb.frame.size.width, 20) title:nil select:@selector(Action:) Tag:2 View:dianzanLb textColor:nil Size:nil background:nil];
    
    
    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, cell.frame.size.height-10, SCREEN_WIDTH, 10) view:cell];
    
    tableview.tableHeaderView=cell;

    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    
    NSDictionary * dic=dataArray[section];

    
    CGFloat hy =[LSFEasy getLabHeight:dic[@"content"] FontSize:font14 Width:SCREEN_WIDTH-20]+10;
    
    UIView * cell=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 120+hy) view:nil backgroundColor:white];
    
    UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake(10, 10, 50, 50) View:cell Tag:1];
    img.layer.cornerRadius=25;
    img.layer.masksToBounds=YES;
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"user"][@"headpic"]]] placeholderImage:[UIImage imageNamed:@"lsf64"]];

    
    
    [LSFUtil labelName:dic[@"user"][@"realname"] fontSize:font14 rect:CGRectMake(70, 10, SCREEN_WIDTH-90, 50) View:cell Alignment:0 Color:black Tag:2];
    
    
    [LSFUtil labelName:[self getTime:dic[@"date"]] fontSize:font14 rect:CGRectMake(0,10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:3];
    

    [LSFUtil labelName:dic[@"content"] fontSize:font14 rect:CGRectMake(10, 70, SCREEN_WIDTH-20, hy) View:cell Alignment:0 Color:gray Tag:4];
    
    
     UIButton*dianzanBtn= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH/2,80+hy, SCREEN_WIDTH/4-10, 20) title:nil select:@selector(DianZanCell:) Tag:section View:cell textColor:gray Size:font14 background:nil];
    
    
     UIButton*pinglunBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH/4+SCREEN_WIDTH/2, 80+hy, SCREEN_WIDTH/4-10, 20) title:nil select:@selector(PingLunCell:) Tag:section View:cell textColor:gray Size:font14 background:nil];
    
    
    [pinglunBtn setAttributedTitle:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %zi",[dic[@"subtopicCustoms"] count]] color:gray image:@"lsf61" type:1 rect:CGRectMake(0, -5, 18, 18)] forState:normal];
    
    [dianzanBtn setAttributedTitle:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",dic[@"praise"]] color:gray image:@"lsf62" type:1 rect:CGRectMake(0, -5, 18, 18)] forState:normal];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, cell.frame.size.height-1, SCREEN_WIDTH, 1) view:[dic[@"subtopicCustoms"] count]==0?cell:nil];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic=dataArray[section];
    CGFloat hy =[LSFEasy getLabHeight:dic[@"content"] FontSize:font14 Width:SCREEN_WIDTH-20]+10;
    
    return 120+hy;
}
#pragma tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * ary=dataArray[section][@"subtopicCustoms"];
    return ary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(30, 10, SCREEN_WIDTH/2-30, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0,10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(30,40, SCREEN_WIDTH-40, 40) View:cell Alignment:0 Color:gray Tag:3];
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 79,SCREEN_WIDTH,1) view:cell];

    }
    
    UILabel * name=(UILabel *)[cell viewWithTag:1];
    UILabel * date=(UILabel *)[cell viewWithTag:2];
    UILabel * content=(UILabel*)[cell viewWithTag:3];

    NSDictionary * dic=dataArray[indexPath.section][@"subtopicCustoms"][indexPath.row];
    
    name.text=dic[@"user"][@"realname"];
    
    date.text=[self getTime:dic[@"date"]];
    
    content.text=dic[@"content"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}


-(void)DianZanCell:(UIButton*)btn{

   

    NSDictionary * dic=dataArray[btn.tag];
    
    
    [self showHudInView:self.view hint:@"加载中"];
    
    Api * api =[[Api alloc] init:self tag:@"topic_praiseSubtopic"];
    [api topic_praiseSubtopic:dic[@"id"]];

    
}

-(void)PingLunCell:(UIButton*)btn{

  
    type=2;
    
    cellTag=btn.tag;
    
    NSDictionary * dic=dataArray[btn.tag];
    
    [self allocText:dic[@"user"][@"realname"]];
    
}

-(void)Action:(UIButton*)btn{

    if(btn.tag==2){
    
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"topic_praisePritopic"];
        [api topic_praisePritopic:_friendModel.friendId];
    
    }
    else if(btn.tag==1){
    
        type=1;
        [self allocText:_friendModel.nickName];
        
    }else{
    
        if(keyText.text.length==0){
        
            [self showHint:@"请输入回复内容"];
            return;
        
        }
        
        [self hiddenBackVew];

        [self showHudInView:self.view hint:@"加载中"];
        
        if(type==1){
        Api * api =[[Api alloc] init:self tag:@"topic_repTopic"];
        [api topic_repTopic:keyText.text pariparentId:itemDic[@"id"]];
        }
        else{
        
            
            NSDictionary * dic=dataArray[cellTag];

            Api * api =[[Api alloc] init:self tag:@"topic_repSubtopic"];
            
            [api topic_repSubtopic:@"回复子主题" content:keyText.text pariparentId:_friendModel.friendId parantId:dic[@"id"]];
        
        }
    
    }
 

}

-(void)hiddenBackVew{

    [keyTextView removeFromSuperview];
    [backView removeFromSuperview];
}
-(void)allocText:(NSString*)name{


    [keyTextView removeFromSuperview];
    [backView removeFromSuperview];
    
    backView=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) view:self.view backgroundColor:black];
    backView.alpha=0.5;
    
    
    UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackVew)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [backView addGestureRecognizer:singleRecognizer];
    
    keyTextView=[LSFUtil viewWithRect:CGRectMake(20,(SCREEN_HEIGHT-160)/2,SCREEN_WIDTH-40, 160) view:self.view backgroundColor:white];
    keyTextView.layer.borderColor=[ColorHUI CGColor];
    keyTextView.layer.borderWidth=1;
    keyTextView.layer.cornerRadius=5;
    keyTextView.layer.masksToBounds=YES;
    
   
    keyText=[LSFUtil addTextView:CGRectMake(10, 10,keyTextView.frame.size.width-20,80) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:[NSString stringWithFormat:@"回复%@: ",name] View:keyTextView font:font14];
    
    
    UIButton * btn1=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 110, keyTextView.frame.size.width/2-20, 40) title:@"取消" select:@selector(hiddenBackVew) Tag:1 View:keyTextView textColor:gray Size:font14 background:white];
    btn1.layer.cornerRadius=4;
    btn1.layer.masksToBounds=YES;
    btn1.layer.borderColor=[ColorHUI CGColor];
    btn1.layer.borderWidth=1;
    
    
    UIButton * btn2=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10+keyTextView.frame.size.width/2, 110, keyTextView.frame.size.width/2-20, 40) title:@"提交" select:@selector(Action:) Tag:3 View:keyTextView textColor:gray Size:font14 background:white];
    btn2.layer.cornerRadius=4;
    btn2.layer.masksToBounds=YES;
    btn2.layer.borderColor=[ColorHUI CGColor];
    btn2.layer.borderWidth=1;
    
    

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
    
    if([tag isEqualToString:@"topic_findPriById"]){
    
        itemDic=response[@"data"];
        [dataArray removeAllObjects];
        dataArray=itemDic[@"subtopicCustoms"];
        [tableview reloadData];
        [self MainViewClass];
      
    }else if ([tag isEqualToString:@"topic_praisePritopic"]){
    
        [self showHint:response[@"msg"]];
      
        [dianzanLb setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %zi",[itemDic[@"praise"] integerValue]+1] color:gray image:@"lsf62" type:1 rect:CGRectMake(0, -5, 18, 18)]];
        
        self.completeBlockNone();
    }
    else if ([tag isEqualToString:@"topic_repTopic"]){
    
        [self showHint:response[@"msg"]];

        [pinglunLb setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %zi",[itemDic[@"reLength"] integerValue]+1] color:gray image:@"lsf61" type:1 rect:CGRectMake(0, -5, 18, 18)]];
        self.completeBlockNone();
        
        Api * api =[[Api alloc] init:self tag:@"topic_findPriById"];
        [api topic_findPriById:_friendModel.friendId];

    
    }
    else if ([tag isEqualToString:@"topic_praiseSubtopic"]||[tag isEqualToString:@"topic_repSubtopic"]){
    
        [self showHint:response[@"msg"]];
        
        Api * api =[[Api alloc] init:self tag:@"topic_findPriById"];
        [api topic_findPriById:_friendModel.friendId];
    }
}


-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}


@end
