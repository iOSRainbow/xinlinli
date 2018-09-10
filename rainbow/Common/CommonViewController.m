//
//  CommonViewController.m
//  deyingSoft
//
//  Created by GuiDaYou on 16/1/23.
//  Copyright © 2016年 李世飞. All rights reserved.
//
#import "CommonViewController.h"


@interface CommonViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CommonViewController


//UIButton
-(UIButton*)buttonPhotoAlignment:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title  select:(SEL)sel Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size background:(UIColor *)background{

    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:photo] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:Hphoto] forState:UIControlStateHighlighted];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    button.titleLabel.font=size;
    button.backgroundColor=background;
    button.contentMode = UIViewContentModeScaleAspectFit;
    
    [ViewA addSubview:button];
    return button;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavView];
    [self initNavTitleView];
    [self addNavBackBtn];
    
    pageIndex=1;
    pageSize=10;
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=MS_RGB(242, 242, 242);
    


   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];

}

-(void)initNavView
{
    //先隐藏系统的导航栏
    self.navigationController.navigationBarHidden=YES;
 
    navView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationHeight)];
    [self.view addSubview:navView];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, NavigationHeight-1, SCREEN_WIDTH, 1) view:navView];

    
}
-(void)initNavTitleView
{
    navTitleLable=[LSFUtil labelName:nil fontSize:font16 rect:CGRectMake(80,StatusHeight+12, SCREEN_WIDTH-160, 20) View:navView Alignment:NSTextAlignmentCenter Color:black Tag:0];
    navTitleLable.userInteractionEnabled=NO;
}

- (void)addNavBackBtn
{
    if (!isModal&&self.navigationController.viewControllers[0]==self) {
        return;
    }
    else
    {
       navBackBtn= [self buttonPhotoAlignment:@"lsf7" hilPhoto:@"lsf7" rect:CGRectMake(5, StatusHeight+7, 30, 30) title:0 select:@selector(actNavBack) Tag:0 View:navView textColor:nil Size:nil background:nil];
    }
    
}

-(void)actNavBack
{
    if (!isModal && self.navigationController) {
        //非模态视图
      
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

#pragma mark - 设置Vc的title
-(void)setNavTitle:(NSString *)title
{
    navTitleLable.text=title;
}

#pragma mark - 导航栏2边按钮的响应处理方法
-(void)actNavLeftBtn
{
    //子类去实现
}

-(void)actNavRightBtn
{
    //子类去实现
}

#pragma mark - 添加导航栏左右按钮的方法(文本和图片)
-(void)addNavLeftBtnWithTitle:(NSString *)title
{
    navLeftBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, StatusHeight, 66, 44) title:title select:@selector(actNavLeftBtn) Tag:0 View:navView textColor:white Size:[UIFont systemFontOfSize:16.0] background:nil];
}

-(void)addNavLeftBtnWithTitle:(NSString *)title rect:(CGRect)rect
{
    navLeftBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:rect title:title select:@selector(actNavLeftBtn) Tag:0 View:navView textColor:white Size:[UIFont systemFontOfSize:16.0] background:nil];
}

-(void)addNavRightBtnWithTitle:(NSString *)title
{
    navRightBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-85, 2+StatusHeight, 80, 40) title:title select:@selector(actNavRightBtn) Tag:0 View:navView textColor:black Size:font15 background:nil];
}
-(void)addNavRightBtnWithTitle:(NSString *)title color:(UIColor *)color
{
    navRightBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-66-10,StatusHeight, 66, 44) title:title select:@selector(actNavRightBtn) Tag:0 View:navView textColor:color Size:[UIFont systemFontOfSize:16.0] background:nil];
    
}

-(void)addNavRightBtnWithTitle:(NSString *)title color:(UIColor *)color rect:(CGRect)rect

{
    navRightBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:rect title:title select:@selector(actNavRightBtn) Tag:0 View:navView textColor:color Size:[UIFont systemFontOfSize:16.0] background:nil];
    navRightBtn.titleLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;

}
-(void)addNavRightBtnWithTitle:(NSString *)title rect:(CGRect)rect
{
    navRightBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:rect title:title select:@selector(actNavRightBtn) Tag:0 View:navView textColor:black Size:font16 background:nil];
}

-(void)addNavLeftBtnWithImage:(NSString *)image rect:(CGRect)rect
{
    navLeftBtn=[self buttonPhotoAlignment:image hilPhoto:image rect:rect title:nil select:@selector(actNavLeftBtn) Tag:0 View:navView textColor:nil Size:nil background:nil];
    
}
-(void)addNavLeftBtnWithImage:(NSString *)image
{
    navLeftBtn=[self buttonPhotoAlignment:image hilPhoto:image rect:CGRectMake(10, StatusHeight, 44, 44) title:nil select:@selector(actNavLeftBtn) Tag:0 View:navView textColor:nil Size:nil background:nil];
}
-(void)addNavRightBtnWithImage:(NSString *)image rect:(CGRect)rect
{
    navRightBtn=[self buttonPhotoAlignment:image hilPhoto:image rect:rect title:nil select:@selector(actNavRightBtn) Tag:0 View:navView textColor:nil Size:nil background:nil];
    
}
-(void)addNavRightBtnWithImage:(NSString *)image
{
    navRightBtn=[self buttonPhotoAlignment:image hilPhoto:image rect:CGRectMake(SCREEN_WIDTH-44-10, StatusHeight, 44, 44) title:nil select:@selector(actNavRightBtn) Tag:0 View:navView textColor:nil Size:nil background:nil];
}
-(void)dealloc{



}
@end
