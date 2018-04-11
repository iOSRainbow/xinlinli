//
//  ScanViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/25.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanCropView.h"

@interface ScanViewController ()

@end

@implementation ScanViewController



//UIButton
-(UIButton*)buttonPhotoAlignment:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title  select:(SEL)sel Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size background:(UIColor *)background {
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
    
    [ViewA addSubview:button];
    return button;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
 

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    num=0;
    isUp=NO;//默认向下
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor=white;
    self.readerDelegate=self;
    
    //在扫描的view上添加描画的界面(和slef.view同大小)
    ScanCropView *cropView=[[ScanCropView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //这里注意设置cropView的透明度,用于控制扫描时周边能否看到后面的东西
    cropView.backgroundColor=MS_RGBA(0, 0, 0, 0.5);
    [self.view addSubview:cropView];
    
    [self createScanRect];
    
    
    navView=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, NavigationHeight) view:self.view backgroundColor:MS_RGB(242, 242, 242)];
    [LSFUtil labelName:@"扫一扫" fontSize:font16 rect:CGRectMake(80, 2+StatusHeight, SCREEN_WIDTH-160, 40) View:navView Alignment:1 Color:black Tag:0];
    
    [self buttonPhotoAlignment:@"lsf7" hilPhoto:@"lsf7" rect:CGRectMake(5, 7+StatusHeight, 30, 30) title:0 select:@selector(actNavBack) Tag:0 View:navView textColor:nil Size:nil background:nil];
   
}


//添加文字和闪光灯按钮
-(void)createScanRect
{
    space=60;
    
    [mainImage removeFromSuperview];
    
    imageW=SCREEN_WIDTH-space*2;
    imageY=(SCREEN_HEIGHT-imageW)/2-50;
    mainImage=[[UIImageView alloc]initWithFrame:CGRectMake(space, imageY, imageW, imageW)];
    mainImage.image=[UIImage imageNamed:@"lsf73"];
 
    
    
    lineLb=[LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake(30,10 , imageW-30*2, 3) view:mainImage];
    lineLb.shadowColor = MS_RGB(250,82,2);
    //阴影偏移  x，y为正表示向右下偏移
    lineLb.shadowOffset = CGSizeMake(1, 1);
    
    //定时器控制扫描线上下移动
    timer=[NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    
    [self.view addSubview:mainImage];
    
    
    
    
    
    
}
-(void)moveAction
{
    if (isUp==NO) {
        num++;
        lineLb.frame=CGRectMake(30, 10+2*num, imageW-30*2, 3);
        if (2*num+10>=imageW) {
            isUp=YES;
        }
    }
    else
    {
        num--;
        lineLb.frame=CGRectMake(30, 10+2*num, imageW-30*2, 3);
        if (2*num<=0) {
            isUp=NO;
        }
        
    }
}

-(void)actNavBack{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController: (UIImagePickerController*) readernow
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    NSMutableString *urlString;
    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
    {
        urlString=[NSMutableString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }
    else{
        urlString=[NSMutableString stringWithString:symbol.data];
    }
    
    NSLog(@"urlString==%@",urlString);
    
    self.completeBlockNSString(urlString);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
