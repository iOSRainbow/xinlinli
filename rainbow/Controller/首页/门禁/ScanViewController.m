//
//  ScanViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/25.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController



-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self StartTimer];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self CleanTimer];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setNavTitle:@"扫一扫"];
    num=0;
    isUp=NO;//默认向下
    space=60;
    imageW=SCREEN_WIDTH-space*2;
    imageY=(SCREEN_HEIGHT-imageW)/2-50;
    
    scanBox= [LSFUtil viewWithRect:CGRectMake(0,NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view backgroundColor:MS_RGBA(0, 0, 0, 0.8)];
    
    [self CreateScanView];
    [self createScanRect];
    
}


-(void)CreateScanView{
    
    
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    // 设置代理，在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 初始化链接对象
    seccion = [[AVCaptureSession alloc]init];
    // 高质量采集率
    [seccion setSessionPreset:AVCaptureSessionPresetHigh];
    
    [seccion addInput:input];
    [seccion addOutput:output];
    
    
    // 设置扫码支持的编码格式（如下设置条形码和二维码兼容）
    output.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // 实例化预览图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:seccion];
    // 设置预览图层填充方式
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = CGRectMake(space, imageY, imageW, imageW);
    [scanBox.layer insertSublayer:layer atIndex:0];
    
}
//添加文字和闪光灯按钮
-(void)createScanRect
{
    UIView * view =[LSFUtil viewWithRect:CGRectMake(space, imageY, imageW, imageW) view:scanBox backgroundColor:nil];
    
    UIImageView * mainImage =[LSFUtil addSubviewImage:@"content_pop_bg_default" rect:CGRectMake(0, 0, imageW, imageW) View:view Tag:1];
    
    lineView=[LSFUtil addSubviewImage:@"content_icon_saomiao_default" rect:CGRectMake(30, 10, imageW-30*2, 3) View:mainImage Tag:1];
    
    infoLable=[LSFUtil labelName:@"将二维码图案放在框内,即可自动扫描。" fontSize:font12 rect:CGRectMake(20,imageY+imageW+20,SCREEN_WIDTH-40,20) View:scanBox Alignment:1 Color:white Tag:1];
}

-(void)StartTimer{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    [seccion startRunning];
    
}
-(void)CleanTimer{
    
    [timer invalidate];
    timer=nil;
    [seccion stopRunning];
    
}

-(void)moveAction
{
    if (isUp==NO) {
        num++;
        lineView.frame=CGRectMake(30, 10+2*num, imageW-30*2, 3);
        if (2*num+10>=imageW) {
            isUp=YES;
        }
    }
    else
    {
        num--;
        lineView.frame=CGRectMake(30, 10+2*num, imageW-30*2, 3);
        if (2*num<=0) {
            isUp=NO;
        }
        
    }
}

-(void)startConnect:(NSString*)str{
    
    // 在连接前先进行手动断开
    [KddSocket sharedInstance].socket.userData = SocketOfflineByUser;
    [[KddSocket sharedInstance] cutOffSocket];
    [KddSocket sharedInstance].delegate=self;
    [[KddSocket sharedInstance] socketConnectHost];
    
    
    Byte table[]={0x8e,0xb5,0x04,0x41};
    NSData *adata = [[NSData alloc] initWithBytes:table length:sizeof(table)];
    
    
    NSString * mobile =UserName;
    NSData * mobileData =[mobile dataUsingEncoding:NSUTF8StringEncoding];
    Byte * mobileByte =(Byte*)[mobileData bytes];
    Byte  mobileTable[mobileData.length];
    for(int i=0;i<[mobileData length];i++){
        
        mobileTable[i]=mobileByte[i];
    }
    
    NSData * adata1=[[NSData alloc] initWithBytes:mobileTable length:sizeof(mobileTable)];
    
    
    
    NSData * codeData =[str dataUsingEncoding:NSUTF8StringEncoding];
    Byte * codeByte =(Byte*)[codeData bytes];
    Byte  codeTable[codeData.length];
    for(int i=0;i<[codeData length];i++){
        
        codeTable[i]=codeByte[i];
    }
    
    NSData * adata3=[[NSData alloc] initWithBytes:codeTable length:sizeof(codeTable)];
    
    Byte table1[]={0x34,0xac};
    NSData * adata2=[[NSData alloc] initWithBytes:table1 length:sizeof(table1)];
    
    
    NSMutableData * data=[[NSMutableData alloc] init];//初始化一个可变data
    [data appendData:adata];
    [data appendData:adata1];
    [data appendData:adata3];
    [data appendData:adata2];
    
    NSLog(@"%@",data);
    [KddSocket sharedInstance].SendToSocketData=data;

}
-(void)message:(NSDictionary *)dic{
    
    
    [self showHint:dic[@"message"]];
    
    NSInteger sucess =[dic[@"sucess"] integerValue];
    
    [KddSocket sharedInstance].socket.userData = SocketOfflineByUser;
    [[KddSocket sharedInstance] cutOffSocket];
    [KddSocket sharedInstance].delegate=nil;

    if(sucess==1){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self StartTimer];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        [self CleanTimer];
        
        NSString * urlString=metadataObject.stringValue;
        if(_type==1){
            
            [self startConnect:urlString];
            return;
        }
        
        self.completeBlockNSString(urlString);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
