//
//  LeadViewController.m
//  KDDBusiness
//
//  Created by 大有 on 16/4/12.
//  Copyright © 2016年 大有. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()

@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, -StatusHeight, SCREEN_WIDTH, SCREEN_HEIGHT+StatusHeight)];
    [webview sizeToFit];
    [self.view addSubview:webview];
    
    
    timeLb=[LSFUtil labelName:@"5" fontSize:font14 rect:CGRectMake(SCREEN_WIDTH-40, 2*StatusHeight, 30, 30) View:webview Alignment:1 Color:Red Tag:1];
    timeLb.layer.cornerRadius=15;
    timeLb.layer.masksToBounds=YES;
    timeLb.layer.borderWidth=2;
    timeLb.layer.borderColor=[Red CGColor];
    
    Api * api =[[Api alloc] init:self tag:@"app_indexPhoto_index"];
    [api app_indexPhoto_index];
    
    [self getTime];

}

#pragma mark -定时器操作
-(void)getTime{
    
    _timestamp=5;
    [timer invalidate];
    timer=nil;
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    if (_timestamp == 0) {
        [timer invalidate];
        timer = nil;
        [[AppDelegate sharedAppDelegate] StartMain];
        
    } else{
        
        timeLb.text=[NSString stringWithFormat:@"%zi",_timestamp];
    }
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag
{

    NSDictionary * dic=response[@"data"];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dic[@"href"]]]];

}


@end
