//
//  JZTypeListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/8/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JZTypeListViewController.h"
#import "JZDetailViewController.h"
#import "GoodsCell.h"
@interface JZTypeListViewController ()

@end

@implementation JZTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:_name];
    
    dataArray=[[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //创建一个UICollectionView对象
    goodCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,NavigationHeight, SCREEN_WIDTH,ViewHeight) collectionViewLayout:flowLayout];
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
    
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"goods_goods"];
    [api goods_goodslist:_type];
    
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
    detail.hidesBottomBarWhenPushed=YES;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"apiError=%@",message);
    [self showHint:message];
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"%@",response);
    [dataArray removeAllObjects];
    dataArray=response[@"data"];
    NSLog(@"后台返回商品个数:%zi",dataArray.count);
    [goodCollectionView reloadData];

}


@end
