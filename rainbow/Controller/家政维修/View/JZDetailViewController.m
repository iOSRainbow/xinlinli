//
//  JZDetailViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JZDetailViewController.h"
#import "JZPayViewController.h"
#import "CommentListViewController.h"
#import "GoodTypeViewController.h"

#define detail_rate 600/750
#define shopPic_height SCREEN_WIDTH*detail_rate


@interface JZDetailViewController ()

@end

@implementation JZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"商品详情"];
    
    self.view.backgroundColor=white;
    
    itemDic=[[NSDictionary alloc] init];
    idStr=@"";
    
    picArray=[[NSArray alloc] init];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"goods_goodsdetail"];
    [api goods_goodsdetail:_goodsId];
    
    
    priceLable=[LSFUtil labelName:nil fontSize:font16 rect:CGRectMake(10,BottomHeight, SCREEN_WIDTH-130, 50) View:self.view Alignment:0 Color:Red Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-120, BottomHeight, 120, 50) title:@"立即购买" select:@selector(PayAction) Tag:1 View:self.view  textColor:white Size:font18 background:Red];
    
}
-(void)PayAction{


    if([LSFEasy isEmpty:idStr]){

        [self showHint:@"请先选择您要购买得商品类型"];
        return;
    }
    NSInteger deposit =[itemDic[@"deposit"] integerValue];
    if(deposit==1){
        
        UIAlertView * alret =[[UIAlertView alloc] initWithTitle:@"此次支付金额仅为该商品的定金" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买", nil];
        [alret show];
        return;
    }

    JZPayViewController * pay =[[JZPayViewController alloc] init];
    pay.IdStr=idStr;
    [self.navigationController pushViewController:pay animated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1){
        
        JZPayViewController * pay =[[JZPayViewController alloc] init];
        pay.IdStr=idStr;
        [self.navigationController pushViewController:pay animated:YES];
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
 
    itemDic=response[@"data"];
    
    picArray =itemDic[@"goodsphotos"];

    [self mainView];
}


-(void)mainView{

    UIView * view=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 90+SCREEN_WIDTH) view:scr backgroundColor:white];
    
    UIImageView * pic =[LSFUtil addSubviewImage:@"lsf64" rect:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH) View:view Tag:1];
    NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,itemDic[@"url"]];
    [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    
    [LSFUtil labelName:itemDic[@"detail"] fontSize:font15 rect:CGRectMake(10, SCREEN_WIDTH+10, SCREEN_WIDTH-20, 40) View:view Alignment:0 Color:black Tag:1];
    
    NSInteger deposit =[itemDic[@"deposit"] integerValue];
    //定金
    NSString * price =[NSString stringWithFormat:@"￥%@~￥%@",itemDic[@"minPrice"],itemDic[@"maxPrice"]];
    if(deposit==1)
    {
        price=[NSString stringWithFormat:@"定金￥%@",itemDic[@"maxPrice"]];
    }else
    {
        if([itemDic[@"minPrice"] doubleValue]==[itemDic[@"maxPrice"] doubleValue]){
            
            price =[NSString stringWithFormat:@"￥%@",itemDic[@"minPrice"]];
        }
    }
    
    [LSFUtil labelName:price fontSize:font15 rect:CGRectMake(10,SCREEN_WIDTH+60, SCREEN_WIDTH-20, 20) View:view Alignment:0 Color:Red Tag:2];
    
    [self goodTypeView:view.frame.size.height];
}

-(void)goodTypeView:(CGFloat)hy{
    
    goodsinfos=itemDic[@"goodsinfos"];
   
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, hy, SCREEN_WIDTH, 40) view:scr backgroundColor:white];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-26, 12, 16, 16) View:view Tag:1];
    
    GoodsName= [LSFUtil labelName:@"请选择商品类型" fontSize:font14 rect:CGRectMake(10,0,SCREEN_WIDTH-50,40) View:view Alignment:0 Color:black Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, SCREEN_WIDTH, 40) title:nil select:@selector(chooseGoodTypeAction) Tag:1 View:view textColor:nil Size:nil background:nil];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, view.frame.size.height-1, SCREEN_WIDTH, 1) view:view];

    
    [self commentView:view.frame.size.height+view.frame.origin.y+10];
}

-(void)chooseGoodTypeAction{
    
    GoodTypeViewController * type =[[GoodTypeViewController alloc] init];
    type.array=[goodsinfos mutableCopy];
    type.completeBlockNSDictionary=^(NSDictionary *dic){
        
        GoodsName.text=dic[@"name"];
        
        NSInteger deposit =[itemDic[@"deposit"] integerValue];
        //定金
        if(deposit==1)
        {
            priceLable.text=[NSString stringWithFormat:@"定金￥%@",itemDic[@"maxPrice"]];
        }else{
            
            priceLable.text=[NSString stringWithFormat:@"￥%@",dic[@"lowprice"]];

        }
        
        idStr=[NSString stringWithFormat:@"%@",dic[@"id"]];
    
    };
    [self.navigationController pushViewController:type animated:YES];
    
}

-(void)commentView:(CGFloat)hy{

    NSArray * ary =itemDic[@"goodscomments"];
    
    CGFloat h=0;
    
    if(ary.count>=2){
        h=50;
    }
    
    UIView * commentview=[LSFUtil viewWithRect:CGRectMake(0, hy, SCREEN_WIDTH, ary.count*80+30+h) view:scr backgroundColor:white];
    
    UILabel*lb= [LSFUtil labelName:@"评论" fontSize:font14 rect:CGRectMake(10, 0, 100, 30) View:commentview Alignment:0 Color:gray Tag:1];
    
    if(ary.count==0){
    
    lb.text=@"暂无评论";
    
    }else{
    
    for(int i=0;i<ary.count;i++){
    
        NSDictionary * dic1=ary[i];
        
        @autoreleasepool {
            
            UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 30+80*i, SCREEN_WIDTH, 80) view:commentview backgroundColor:white];
            
            UILabel*lb= [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-20, 20) View:view Alignment:0 Color:Red Tag:1];
            
            NSString* str=[NSString stringWithFormat:@"%@   %@",dic1[@"username"],dic1[@"satis"]];
            
            NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:str];
            
            
            [attri addAttribute:NSForegroundColorAttributeName
             
                          value:gray
             
                          range:NSMakeRange(0, [dic1[@"username"] length])];
            
            
            lb.attributedText=attri;
            
            
            [LSFUtil labelName:[self getTime:dic1[@"entrytime"]] fontSize:font14 rect:CGRectMake(0, 10, SCREEN_WIDTH-10, 20) View:view Alignment:2 Color:gray Tag:1];

            
            [LSFUtil labelName:dic1[@"detail"] fontSize:font14 rect:CGRectMake(10, 30, SCREEN_WIDTH-20, 40) View:view Alignment:0 Color:gray Tag:1];
            
            
            [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 79, SCREEN_WIDTH, 1) view:view];
            
        }
    
    }

}

    UIButton *btn= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(50, commentview.frame.size.height-40, SCREEN_WIDTH-100, 40) title:@"查看更多评价" select:@selector(CommentAction) Tag:1 View:ary.count>=2?commentview:nil textColor:orange Size:font18 background:white];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    btn.layer.borderWidth=1;
    btn.layer.borderColor=[orange CGColor];

    
   [self photoView:commentview.frame.size.height+hy+20];
}

-(void)CommentAction{
  
    CommentListViewController * list =[[CommentListViewController alloc] init];
    list.goodsId=_goodsId;
    [self.navigationController pushViewController:list animated:YES];

}

-(void)photoView:(CGFloat)hy{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 40) view:scr backgroundColor:white];
    
    [LSFUtil setXianTiao:Red rect:CGRectMake(10, 10, SCREEN_WIDTH/3-20, 1) view:view];
    [LSFUtil labelName:@"图文详情" fontSize:font16 rect:CGRectMake(SCREEN_WIDTH/3,0,SCREEN_WIDTH/3,20) View:view Alignment:1 Color:Red Tag:1];
    
    [LSFUtil setXianTiao:Red rect:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/3+10,10, SCREEN_WIDTH/3-20, 1) view:view];
    
    CGFloat hh =hy+40;
    
   
    for(int i=0;i<picArray.count;i++){
    
        NSDictionary * dic=picArray[i];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
        
        NSLog(@"url===%@",url);
        
        UIImageView * picImg =[LSFUtil addSubviewImage:nil rect:CGRectMake(0,i*shopPic_height+hh, SCREEN_WIDTH, shopPic_height) View:scr Tag:1];
        
        [picImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
    }


    scr.contentSize=CGSizeMake(0, picArray.count*shopPic_height+hh);

}


-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}

@end
