//
//  SearchViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/2/26.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"商品搜素"];
    dataArray=[[NSMutableArray alloc] init];
    [self initSearchBar];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //创建一个UICollectionView对象
    goodCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,NavigationHeight+55, SCREEN_WIDTH,ViewHeight-55) collectionViewLayout:flowLayout];
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
    searchText=[LSFUtil addTextFieldView:CGRectMake(30,0,searchView.frame.size.width-40, 45) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"寻找你需要的服务" View:searchView font:nil];
    searchText.font=[UIFont systemFontOfSize:14.0];
    searchText.delegate=self;
    [searchText becomeFirstResponder];
    searchText.returnKeyType = UIReturnKeySearch;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(searchText.text.length==0){
        
        [self showHint:@"请输入关键词"];
        return NO;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"goods_search"];
    [api goods_search:searchText.text];
    
    return YES;
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"apiError=%@",message);
    [self showHint:message];
    [emptyView removeFromSuperview];

}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"%@",response);
    [emptyView removeFromSuperview];
    [dataArray removeAllObjects];
    dataArray=response[@"data"];
    if(dataArray.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight) view:goodCollectionView title:@"未搜索到类似商品"];
    }
    
    [goodCollectionView reloadData];
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
    
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    NSDictionary * dic =dataArray[indexPath.row];
    
    NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
    
    [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    
    cell.goodName.text=dic[@"name"];
    
    [cell.goodContent setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",dic[@"detail"]] color:gray image:@"lsf80" type:1 rect:CGRectMake(0,0, 20, 12)]];
    
    cell.goodPrice.text=[NSString stringWithFormat:@"￥%@",dic[@"price"]];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic=dataArray[indexPath.row];
    JZDetailViewController * detail =[[JZDetailViewController alloc] init];
    detail.goodsId=dic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_WIDTH/2,SCREEN_WIDTH/2+90);
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
@end
