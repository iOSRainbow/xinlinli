//
//  WXTipDetailViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WXTipDetailViewController.h"

@interface WXTipDetailViewController ()

@end

@implementation WXTipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"公告内容"];
    
    self.view.backgroundColor=white;
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, _model.content_height+_model.picView_height+TabbarHeight+85)];
    
    [LSFUtil labelName:_model.title fontSize:font16 rect:CGRectMake(10,0, SCREEN_WIDTH-15, 40) View:scr Alignment:1 Color:black Tag:1];
    
    UILabel*content=[LSFUtil labelName:_model.content fontSize:font14 rect:CGRectMake(10,40, SCREEN_WIDTH-15, _model.content_height) View:scr Alignment:0 Color:gray Tag:1];
    content.lineBreakMode=NSLineBreakByTruncatingTail;

    
 
    UIView * picView=[LSFUtil viewWithRect:CGRectMake(0, _model.content_height+50, SCREEN_WIDTH, _model.picView_height) view:scr backgroundColor:nil];

    CGFloat itemBtnW = picView.frame.size.width/3;
    CGFloat itemBtnH = picView.frame.size.height/2;
    
    for(int i=0;i<_model.picArray.count;i++){
        
        
        NSDictionary * dic =_model.picArray[i];
        
        CGFloat itemBtnX = i/6 *picView.frame.size.width + (i%(6/2))*itemBtnW;
        CGFloat itemBtnY = ((i - (i/6)*6)/(6/2))*itemBtnH;
        
        UIView * view =[LSFUtil viewWithRect:CGRectMake(itemBtnX,itemBtnY,itemBtnW,itemBtnH) view:picView backgroundColor:white];
        
        UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake((view.frame.size.width-90)/2,5,90,90) View:view Tag:1];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=info",urlStr,dic[@"url"]];
        
        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
        UIButton * btn =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil Tag:i View:view textColor:nil Size:nil];
        [btn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [LSFUtil labelName:_model.cellName fontSize:font12 rect:CGRectMake(10, picView.frame.size.height+picView.frame.origin.y+10, SCREEN_WIDTH-150, 20) View:scr Alignment:0 Color:gray Tag:3];
    
    [LSFUtil labelName:_model.date fontSize:font12 rect:CGRectMake(SCREEN_WIDTH-140, picView.frame.size.height+picView.frame.origin.y+10, 135, 20) View:scr Alignment:2 Color:gray Tag:4];
    
}



-(void)photo:(UIButton *)btn{
    
    NSArray * ary =_model.picArray;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [ary count]];
    
    for (int i = 0; i < [ary count]; i++) {
        // 替换为中等尺寸图片
        
        NSDictionary * dic=ary[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=info",urlStr,dic[@"url"]];
        
        photo.url=[NSURL URLWithString:url];
        
        [photo.srcImageView sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"lsf63"]];
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex =btn.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
