//
//  AddFriendViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/13.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "AddFriendViewController.h"
#import "ZLPhoto.h"

@interface AddFriendViewController ()<ZLPhotoPickerViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@implementation AddFriendViewController


-(void)actNavRightBtn{

    if(lptext.text.length==0){
    
        [self showHint:@"发布内容不能为空"];
        return;
    
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"pubTopic"];
    [api pubTopic:@"主题" content:lptext.text size:picArray.count picArray:picArray];

}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"发布见闻"];
    [self addNavRightBtnWithTitle:@"发布" rect:CGRectMake(SCREEN_WIDTH-50,22, 40, 40)];
    
    picArray=[[NSMutableArray alloc] init];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, 300+TabbarHeight)];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 240) view:scr backgroundColor:white];
    
    lptext=[LSFUtil addTextView:CGRectMake(10, 10, SCREEN_WIDTH-20, 80) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"有什么好玩的告诉大家?" View:view font:font14];
    
    
    picStr=[LSFUtil add_scollview:CGRectMake(10,110, SCREEN_WIDTH-20,110) Tag:1 View:view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    [self reloadScrollView];
    
    
}


- (void)reloadScrollView{
    
    [picStr.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    NSMutableArray *arr = [picArray mutableCopy];
    if (arr.count < 4) {
        [arr addObject:[UIImage imageNamed:@"lsf41"]];
    }
    NSInteger wid = 70;
    for (int i = 0; i < arr.count; i++) {
        if (i == arr.count - 1 && picArray.count < 4) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((i+1)*10 + wid*i, 20, wid, wid);
            [btn setImage:arr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [picStr addSubview:btn];
        }
        else
        {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake((i+1)*10 + wid*i, 20, wid, wid);
            imgView.contentMode=UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds=YES;
            imgView.image=[UIImage imageWithData:picArray[i]];
            
            imgView.userInteractionEnabled = YES;
            UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleBtn setImage:[UIImage imageNamed:@"lsf42"] forState:UIControlStateNormal];
            deleBtn.frame = CGRectMake(imgView.bounds.size.width - 30, 0, 30, 30);
            deleBtn.tag = i;
            [deleBtn addTarget:self action:@selector(deleBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:deleBtn];
            [picStr addSubview:imgView];
        }
        
    }
    picStr.contentSize = CGSizeMake((wid + 10) * arr.count + 10, 0);
}


- (void)deleBtn_click:(UIButton *)btn
{
    [picArray removeObjectAtIndex:btn.tag];
    [self reloadScrollView];
}

- (void)addBtn_click:(UIButton *)btn
{
    
    UIAlertController* alertView=[UIAlertController alertControllerWithTitle:@"请选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *actionPhoto=[UIAlertAction actionWithTitle:@"本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self createZLPickerVc];
        
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertView addAction:actionCamera];
    [alertView addAction:actionPhoto];
    [alertView addAction:actionCancel];
    
    [self presentViewController:alertView animated:YES completion:nil];
    
}

#pragma mark -获取图片的方法
//拍照
- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showHint:@"该机型不支持拍照"];
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//创建图片多选择器
- (void)createZLPickerVc
{
    // 创建图片多选控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusSavePhotos;
    // 选择图片的最小数
    pickerVc.maxCount = 6 - picArray.count;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}


#pragma mark -ImagePicker回调

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    //UIImagePickerControllerOriginalImage
    //初始化imageNew为从相机中获得的--
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 得到图片的缓存数据
    NSData * imagedata = UIImageJPEGRepresentation(imageNew, 0.5f);
    [picArray addObject:imagedata];
    
    [self reloadScrollView];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
{
    for (NSInteger i = 0 ; i < assets.count ; i++) {
        ZLPhotoAssets *asset = assets[i];
        if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
            UIImage *originalImage = asset.originImage;
            
            // 得到图片的缓存数据
            NSData * imagedata = UIImageJPEGRepresentation(originalImage, 0.5f);
            [picArray addObject:imagedata];
        }
    }
    
    [self reloadScrollView];
    
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
    [self showHint:response[@"msg"]];
    
    self.completeBlockNone();
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
