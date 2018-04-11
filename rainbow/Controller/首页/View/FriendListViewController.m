//
//  FriendListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "FriendListViewController.h"
#import "AddFriendViewController.h"
#import "Friend.h"
#import "FriendDetailViewController.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


@interface FriendListViewController ()

@end

@implementation FriendListViewController

-(void)actNavRightBtn{

    AddFriendViewController * add =[[AddFriendViewController alloc] init];
    add.completeBlockNone=^{
    
        [self getData];
    };
    [self.navigationController pushViewController:add animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"邻里圈"];
    
    [self addNavRightBtnWithImage:@"lsf60" rect:CGRectMake(SCREEN_WIDTH-30,22+10, 20, 20)];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self getData];
}

-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"topic_pritopicList"];
    [api topic_pritopicList:0];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    Friend * friend=dataArray[indexPat.row];

    return friend.Contentheight+120+friend.Photoheight;
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
        
        
        UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake(10, 10, 50, 50) View:cell Tag:1];
        img.layer.cornerRadius=25;
        img.layer.masksToBounds=YES;
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(70, 10, SCREEN_WIDTH-90, 50) View:cell Alignment:0 Color:black Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0,10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:5];

        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(80, 35, SCREEN_WIDTH-90, 40) View:cell Alignment:0 Color:gray Tag:3];
        
        UIView *imgView=[LSFUtil viewWithRect:CGRectMake(10, 80, SCREEN_WIDTH-20, 80) view:cell backgroundColor:nil];
        imgView.tag=4;
        
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, 0, 0) title:nil select:@selector(PhotoAction:) Tag:6666 View:cell textColor:nil Size:nil background:nil];
        
        
        
       [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 80, SCREEN_WIDTH/2, 20) View:cell Alignment:0 Color:gray Tag:6];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 80, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:7];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 80, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:8];


        
       UILabel*line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 110, SCREEN_WIDTH, 10) view:cell];
        line.tag=9;
        
    }

    
    UIImageView * headPic =(UIImageView *)[cell viewWithTag:1];
    UILabel * lb1 =(UILabel *)[cell viewWithTag:2];
    UILabel * lb2 =(UILabel *)[cell viewWithTag:3];
    UIView * imgView=(UIView*)[cell viewWithTag:4];
    UILabel * lb3 =(UILabel *)[cell viewWithTag:5];
    UILabel * lb4 =(UILabel *)[cell viewWithTag:6];
    UILabel * lb5 =(UILabel *)[cell viewWithTag:7];
    UILabel * lb6 =(UILabel *)[cell viewWithTag:8];
    UILabel * lb7 =(UILabel *)[cell viewWithTag:9];
    UIButton * btn =(UIButton*)[cell viewWithTag:6666];


    
    Friend * friend =dataArray[indexPath.row];
    
    [headPic sd_setImageWithURL:[NSURL URLWithString:friend.headPicUrl] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    lb1.text=friend.nickName;
    lb3.text=friend.date;
    
    lb2.text=friend.content;
    lb2.frame=CGRectMake(10, 70, SCREEN_WIDTH-20, friend.Contentheight);
    
    
    NSMutableArray * ary =friend.photoListAry;
    
    imgView.hidden=ary.count==0?YES:NO;
    
    [imgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    imgView.frame=CGRectMake(10, friend.Contentheight+70,SCREEN_WIDTH-20, friend.Photoheight);
    
    btn.frame=imgView.frame;
    
    for(int i=0;i<ary.count;i++){
    
        NSInteger index=i%3;
        NSInteger page=i/3;
        
        NSDictionary * dic=ary[i];
        
        UIView * view =[LSFUtil viewWithRect:CGRectMake((imgView.frame.size.width/3)*index, 90*page,imgView.frame.size.width/3, 90) view:imgView backgroundColor:nil];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=i",urlStr,dic[@"photourl"]];
        
        UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake((view.frame.size.width-80)/2,5, 80, 80) View:view Tag:1];
        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, 90) title:nil select:@selector(PhotoAction:) Tag:i View:view textColor:nil Size:nil background:nil];
    }
    
    lb4.frame=CGRectMake(10, friend.Contentheight+80+friend.Photoheight, SCREEN_WIDTH-20, 20);
    
    lb5.frame=CGRectMake(SCREEN_WIDTH/4+SCREEN_WIDTH/2, friend.Contentheight+80+friend.Photoheight, SCREEN_WIDTH/4-10, 20);
    
    lb6.frame=CGRectMake(SCREEN_WIDTH/2, friend.Contentheight+80+friend.Photoheight, SCREEN_WIDTH/4-10, 20);

    
    lb7.frame=CGRectMake(0, friend.Contentheight+110+friend.Photoheight, SCREEN_WIDTH, 10);

    
    [lb4 setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",friend.cellName] color:gray image:@"lsf63" type:1 rect:CGRectMake(0, -4, 20, 20)]];
    
    [lb5 setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",friend.pinglunNumStr] color:gray image:@"lsf61" type:1 rect:CGRectMake(0, -5, 18, 18)]];
    
    [lb6 setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",friend.dianzanNumStr] color:gray image:@"lsf62" type:1 rect:CGRectMake(0, -5, 18, 18)]];

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendDetailViewController * d =[[FriendDetailViewController alloc] init];

    Friend * friend =dataArray[indexPath.row];
    
    d.friendModel=friend;
    
    d.completeBlockNone=^{
        
        [self getData];
    };
    [self.navigationController pushViewController:d animated:YES];
    
}

-(void)PhotoAction:(UIButton*)btn{

    
  
    
    if(IOS8_OR_LATER)
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;
    }
    else
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;
        
    }
    
    Friend * friend=dataArray[cellTag];

    NSMutableArray * ary =friend.photoListAry;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [ary count]];

    for (int i = 0; i < [ary count]; i++) {
        // 替换为中等尺寸图片
        
        NSDictionary * dic=ary[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=i",urlStr,dic[@"photourl"]];
    
        photo.url=[NSURL URLWithString:url];
        
        [photo.srcImageView sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"lsf63"]];
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex =0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    [emptyView removeFromSuperview];

    emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    [dataArray removeAllObjects];
    [emptyView removeFromSuperview];

    NSMutableArray * ary =response[@"data"];
    if(ary.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];

        return;
    }
    
    for(int i=0;i<ary.count;i++){
    
        NSDictionary * dic=ary[i];
        Friend * friend =[[Friend alloc] init];
        friend.headPicUrl=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"user"][@"headpic"]];
        friend.nickName=dic[@"user"][@"realname"];
        friend.content=dic[@"content"];
        friend.date=[self getTime:dic[@"date"]];
        
        NSMutableArray * picArray=dic[@"topicphotos"];
        friend.photoListAry=picArray;
        friend.cellName=dic[@"cell"][@"name"];
        friend.dianzanNumStr=[NSString stringWithFormat:@"%@",dic[@"praise"]];
        friend.pinglunNumStr=[NSString stringWithFormat:@"%@",dic[@"reLength"]];
        
        friend.friendId=dic[@"id"];
        
        CGFloat hy =[LSFEasy getLabHeight:dic[@"content"] FontSize:font14 Width:SCREEN_WIDTH-20];
        friend.Contentheight=hy+10;
        
        
        if(picArray.count==0){
        
        
            friend.Photoheight=0;
        
        }else{
        
            friend.Photoheight=(picArray.count<=3)?90:180;
        }

        [dataArray addObject:friend];
    }
    
    [tableview reloadData];
    
}


-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}
@end
