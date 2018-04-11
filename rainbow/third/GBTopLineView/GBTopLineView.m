//
//  GBTopLineView.m
//  淘宝垂直跑马灯广告
//
//  Created by 张国兵 on 15/8/28.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBTopLineView.h"

@interface GBTopLineView(){
    
    NSTimer *_timer;     //定时器
    int count;
    int flag; //标识当前是哪个view显示(currentView/hidenView)
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong) UIView *currentView;   //当前显示的view
@property (nonatomic,strong) UIView *hidenView;     //底部藏起的view
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UIButton *currentBtn;
@property (nonatomic,strong) UIImageView *currentImage;

@property (nonatomic,strong) UIButton *hidenBtn;
@property (nonatomic,strong) UILabel *hidenLabel;
@property (nonatomic,strong) UIImageView *hidenImage;

@end
@implementation GBTopLineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    //创建定时器
    [self createTimer];
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
    //改进
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self addGestureRecognizer:longPress];
    
    
}
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    NSLog(@"dataArr-->%@",dataArr);
    GBTopLineViewModel *model = _dataArr[count];
    //[self.currentBtn setTitle:model.type forState:UIControlStateNormal];
    
    [self.currentImage sd_setImageWithURL:[NSURL URLWithString:model.type] placeholderImage:nil];
    
    self.currentLabel.text = model.title;
}


-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    
    if(longPress.state==UIGestureRecognizerStateEnded){
        
        _timer.fireDate=[NSDate distantPast];
        
        
    }
    if(longPress.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
    }
    
    
    
    
}
- (void)dealTap:(UITapGestureRecognizer *)tap
{
    self.clickBlock(count);
}

- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

#pragma mark - 跑马灯操作
-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 1) {
         GBTopLineViewModel*currentModel = _dataArr[count];
        //[self.currentBtn setTitle:currentModel.type forState:UIControlStateNormal];
        [self.currentImage sd_setImageWithURL:[NSURL URLWithString:currentModel.type] placeholderImage:nil];
        self.currentLabel.text = currentModel.title;
    }
    
    if (flag == 0) {
        GBTopLineViewModel *hienModel = _dataArr[count];
        //[self.hidenBtn setTitle:hienModel.type forState:UIControlStateNormal];
        [self.hidenImage sd_setImageWithURL:[NSURL URLWithString:hienModel.type] placeholderImage:nil];
        self.hidenLabel.text = hienModel.title;
    }
    
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)createCurrentView
{
    GBTopLineViewModel *model = _dataArr[count];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
   
    /*
    //此处是类型按钮(不需要点击)
    self.currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currentBtn.frame = CGRectMake(10, 10, 30, self.currentView.frame.size.height-20);
    self.currentBtn.layer.masksToBounds = YES;
    self.currentBtn.layer.cornerRadius = 5;
    self.currentBtn.layer.borderWidth = 1;
    self.currentBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.currentBtn setTitle:model.type forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.currentView addSubview:self.currentBtn];
    */
    
    //此处是类型图片
    self.currentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-15)/2, 15, 15)];
   // [self.currentView addSubview:self.currentImage];
    
    //内容标题
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.currentView.frame.size.width, 40)];
    self.currentLabel.text = model.title;
    self.currentLabel.textAlignment = 0;
    self.currentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.currentLabel.numberOfLines=0;
    self.currentLabel.textColor = [UIColor blackColor];
    self.currentLabel.font = font13;
    [self.currentView addSubview:self.currentLabel];
}

- (void)createHidenView
{
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];
    
   /* //此处是类型按钮(不需要点击)
    self.hidenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hidenBtn.frame = CGRectMake(10, 10, 30, self.hidenView.frame.size.height-20);
    self.hidenBtn.layer.masksToBounds = YES;
    self.hidenBtn.layer.cornerRadius = 5;
    self.hidenBtn.layer.borderWidth = 1;
    self.hidenBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.hidenBtn setTitle:@"" forState:UIControlStateNormal];
    [self.hidenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.hidenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.hidenView addSubview:self.hidenBtn];*/
    //此处是类型图片
    self.hidenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-15)/2, 15, 15)];
    [self.hidenView addSubview:self.hidenImage];
    
    //内容标题
    self.hidenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hidenView.frame.size.width,40)];
    self.hidenLabel.text = @"";
    self.hidenLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.hidenLabel.numberOfLines=0;
    self.hidenLabel.textColor = [UIColor blackColor];
    self.hidenLabel.font = font13;
    [self.hidenView addSubview:self.hidenLabel];
}

#pragma mark - 停止定时器
- (void)stopTimer
{
    //停止定时器
    //在invalidate之前最好先用isValid先判断是否还在线程中：
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
