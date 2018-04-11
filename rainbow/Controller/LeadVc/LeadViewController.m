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
    
    
    appImg=[LSFUtil addSubviewImage:nil rect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) View:self.view Tag:1];
    
    timeLb=[LSFUtil labelName:@"3" fontSize:font14 rect:CGRectMake(SCREEN_WIDTH-40, StatusHeight, 30, 30) View:appImg Alignment:1 Color:Red Tag:1];
    timeLb.layer.cornerRadius=15;
    timeLb.layer.masksToBounds=YES;
    timeLb.layer.borderWidth=2;
    timeLb.layer.borderColor=[Red CGColor];
    
    [self getTime];

    
    Api * api =[[Api alloc] init:self tag:@"app_indexPhoto_index"];
    [api app_indexPhoto_index];
    
}

#pragma mark -定时器操作
-(void)getTime{
    
    _timestamp=3;
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
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:true] forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
    
    NSLog(@"%@",response);
    
    [self hideHud];
    //indexphoto
    NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=a",urlStr,response[@"data"][@"indexphoto"]];
    
    [appImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];

}

@end
