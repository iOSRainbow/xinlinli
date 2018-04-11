//
//  MoreTypeViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/31.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "MoreTypeViewController.h"


@interface MoreTypeViewController ()

@end

@implementation MoreTypeViewController

-(void)actNavRightBtn{

    
    NSMutableArray * ary=[[NSMutableArray alloc] init];
    for(int i=0;i<gouArray.count;i++){
    
        NSInteger a =[gouArray[i] integerValue];
        if(a==1){
        //1-  0+
            NSDictionary * dic=@{@"name":nameArray[i],@"pic":imgArray[i]};
            [ary addObject:dic];
        }
    
    }
    
    if(ary.count>7){
    
        [self showHint:@"热门模块最多只能选7个"];
        return;
    }
    
    NSDictionary * dic=@{@"name":@"更多分类",@"pic":@"lsf74"};
    [ary insertObject:dic atIndex:ary.count];
    
    self.completeBlockMutableArray(ary);
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"全部分类"];
    [self addNavRightBtnWithTitle:@"完成" rect:CGRectMake(SCREEN_WIDTH-80, StatusHeight+2, 80, 40)];
    self.view.backgroundColor=white;
    gouArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
    nameArray =[[NSMutableArray alloc] initWithObjects:@"物业公告",@"物业维修",@"门禁",@"车位锁",@"居家服务",@"邻里圈",@"礼品兑换",@"室内环保",@"家政服务",@"家电清洗", nil];
    imgArray=[[NSMutableArray alloc] initWithObjects:@"lsf46",@"lsf47",@"lsf48",@"lsf92",@"lsf52",@"lsf49",@"lsf50",@"lsf96",@"lsf97",@"lsf98",nil];

    
    for(int i=0;i<_dicAray.count;i++){
    
        NSDictionary * dic =_dicAray[i];
        
        for(int j=0;j<nameArray.count;j++){
        
            NSString * str =nameArray[j];
            
            if([dic[@"name"] isEqual:str]){
            
                [gouArray replaceObjectAtIndex:j withObject:@"1"];
            }
        }
    
    
    }
    
    
    
    menuView =[LSFUtil viewWithRect:CGRectMake(0,NavigationHeight+15, SCREEN_WIDTH, 300) view:self.view backgroundColor:white];
    
    [self addBtnMenu];
    
}
-(void)addBtnMenu{

    
    [menuView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    for(int i=0;i<nameArray.count;i++){
        
        NSInteger index = i%4;
        NSInteger page = i/4;
        NSInteger a =[gouArray[i] integerValue];
        
        UIView * view=[LSFUtil viewWithRect:CGRectMake(index*(SCREEN_WIDTH/4), page*100, SCREEN_WIDTH/4, 100) view:menuView backgroundColor:nil];
        
        UIImageView*img=[LSFUtil addSubviewImage:[NSString stringWithFormat:@"%@",imgArray[i]] rect:CGRectMake((view.frame.size.width-50)/2, 10, 50, 50) View:view Tag:1];
        
        [LSFUtil addSubviewImage:a==1?@"lsf75":@"lsf76" rect:CGRectMake(35,0, 15, 15) View:img Tag:1];
        
        [LSFUtil labelName:nameArray[i] fontSize:font14 rect:CGRectMake(0, 70, view.frame.size.width, 20) View:view Alignment:1 Color:black Tag:1];
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, 100) title:nil select:@selector(Action:) Tag:i View:view textColor:nil Size:nil background:nil];
    }
    

}
-(void)Action:(UIButton*)btn{

    NSInteger a =[gouArray[btn.tag] integerValue];
    
    [gouArray replaceObjectAtIndex:btn.tag withObject:a==1?@"0":@"1"];
    
    [self addBtnMenu];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
