//
//  JZListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JZListViewController.h"
#import "JZDetailViewController.h"
#import "GoodsCell.h"
#import "OrderListViewController.h"
#import "SearchViewController.h"
@interface JZListViewController ()

@end

@implementation JZListViewController

-(void)actNavRightBtn{
    
    OrderListViewController * list =[[OrderListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"商品分类"];
    [self addNavRightBtnWithTitle:@"服务记录"];
    self.view.backgroundColor=white;
    goodsArray=[[NSMutableArray alloc] init];
    nameArray=[[NSMutableArray alloc] init];
    gouArray=[[NSMutableArray alloc] init];
    
    [self initSearchBar];
    
    nameTableview=[LSFUtil add_tableview:CGRectMake(0, 55+NavigationHeight, 100,ViewHeight-55) Tag:1 View:self.view delegate:self dataSource:self];

    [self showHudInView:self.view hint:@"加载中"];
    
    Api * api =[[Api alloc] init:self tag:@"goods_goodstypelist"];
    [api goods_goodstypelist];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //创建一个UICollectionView对象
    goodCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, NavigationHeight+55, SCREEN_WIDTH-100, ViewHeight-55) collectionViewLayout:flowLayout];
    //配置collectionView的背景颜色
    goodCollectionView.backgroundColor = [UIColor whiteColor];
    //指定数据源代理
    goodCollectionView.dataSource = self;
    //注册Cell
    [goodCollectionView registerClass:[GoodsCell  class] forCellWithReuseIdentifier:@"item"];
    goodCollectionView.alwaysBounceVertical = YES;
    //设置业务代理
    goodCollectionView.delegate = self;
    [self.view addSubview:goodCollectionView];
    
   [self getdata:@"0"];
    
}


#pragma mark 列表搜索
-(void)initSearchBar
{
    UIView *searchView=[LSFUtil viewWithRect:CGRectMake(10,NavigationHeight+5,SCREEN_WIDTH-20,45) view:self.view backgroundColor:white];
    searchView.layer.cornerRadius=8;
    searchView.layer.masksToBounds=YES;
    searchView.layer.borderColor=ColorHUI.CGColor;
    searchView.layer.borderWidth=1;
    
    [LSFUtil addSubviewImage:@"icon_home_search" rect:CGRectMake(10,15, 15, 15) View:searchView Tag:0];
    
    [LSFUtil labelName:@"寻找你需要的服务" fontSize:font14 rect:CGRectMake(30,0,searchView.frame.size.width-40, 45) View:searchView Alignment:0 Color:gray Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, searchView.frame.size.width, searchView.frame.size.height) title:nil select:@selector(SearchAction) Tag:1 View:searchView textColor:nil Size:nil background:nil];
  
}

-(void)getdata:(NSString*)type{

    Api * api  =[[Api alloc] init:self tag:@"goods_goodslist"];
    [api goods_goodslist:type];

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
    
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 0, 100, 50) View:cell Alignment:1 Color:black Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 0, 2, 50) View:cell Alignment:0 Color:MS_RGB(250,82,2) Tag:2];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, 100, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    UILabel * line =(UILabel *)[cell viewWithTag:2];

    
    NSDictionary * dic=nameArray[indexPath.row];
    
    NSInteger a=[gouArray[indexPath.row] integerValue];
    
    lb1.textColor=a==1?MS_RGB(250,82,2):black;
    
    line.hidden=a==1?NO:YES;
    line.backgroundColor=MS_RGB(250,82,2);
    
    lb1.text=dic[@"name"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [gouArray removeAllObjects];
    for(int i=0;i<nameArray.count;i++){
        
        [gouArray addObject:@"0"];
    }

    
    NSDictionary * dic=nameArray[indexPath.row];
    [self getdata:dic[@"id"]];
   
    [gouArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    
    [nameTableview reloadData];
    
    
}



-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"goods_goodstypelist"]){
    
        [gouArray removeAllObjects];
        [nameArray removeAllObjects];
        
        nameArray=response[@"data"];
        
        NSLog(@"%@",nameArray);
        
        NSDictionary * dic=@{@"id":@"0",@"name":@"全部分类"};
        [nameArray insertObject:dic atIndex:0];
        
        for(int i=0;i<nameArray.count;i++){
        
            [gouArray addObject:i==0?@"1":@"0"];
        }
        
        [nameTableview reloadData];
    
    }
    else if ([tag isEqualToString:@"goods_goodslist"]){
    
    
        [goodsArray removeAllObjects];
         goodsArray=response[@"data"];
        [goodCollectionView reloadData];
    
    }
    
}



#pragma collectionview
//返回每个分区Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return goodsArray.count;
}
//返回collectionView分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//根据indexPath 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    NSDictionary * dic =goodsArray[indexPath.row];
    
    NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
    
    [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    cell.goodName.text=dic[@"name"];
    
    [cell.goodContent setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",dic[@"detail"]] color:gray image:@"lsf80" type:1 rect:CGRectMake(0,0, 20, 12)]];
    
    cell.goodPrice.text=[NSString stringWithFormat:@"￥%@",dic[@"price"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic=goodsArray[indexPath.row];
    JZDetailViewController * detail =[[JZDetailViewController alloc] init];
    detail.hidesBottomBarWhenPushed=YES;
    detail.goodsId=dic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-100)/2,(SCREEN_WIDTH-100)/2+90);
}
//返回分区缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0,0,0);
    
}

//返回每一行item之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}
//返回item之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)SearchAction{
    
    SearchViewController * search =[[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

@end
