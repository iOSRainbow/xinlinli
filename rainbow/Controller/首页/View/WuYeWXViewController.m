//
//  WuYeWXViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WuYeWXViewController.h"
#import "ZLPhoto.h"
#import "BaoXiuTypeViewController.h"
#import "GetUserAddressViewController.h"
#import "WXListViewController.h"

@interface WuYeWXViewController ()<ZLPhotoPickerViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@end

@implementation WuYeWXViewController

-(void)actNavRightBtn{

    WXListViewController * wx=[[WXListViewController alloc] init];
    [self.navigationController pushViewController:wx animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"报修"];
    [self addNavRightBtnWithTitle:@"报修记录"];

    picArray=[[NSMutableArray alloc] init];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight-50) Tag:1 View:self.view co:CGSizeMake(0, 490)];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(10, 20, SCREEN_WIDTH-20, 440) view:scr backgroundColor:white];
    view.layer.cornerRadius=5;
    view.layer.masksToBounds=YES;
    
    [LSFUtil addSubviewImage:@"lsf58" rect:CGRectMake(10, 15, 20, 20) View:view Tag:1];
    usernameText=[LSFUtil addTextFieldView:CGRectMake(40, 0, view.frame.size.width-50, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"称呼" View:view font:font14];
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50, SCREEN_WIDTH, 1) view:view];
    
    
    [LSFUtil addSubviewImage:@"lsf59" rect:CGRectMake(10, 50+(50-41/2)/2, 11, 41/2) View:view Tag:1];
    phoneText=[LSFUtil addTextFieldView:CGRectMake(40, 50, view.frame.size.width-50, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"手机" View:view font:font14];
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 100, SCREEN_WIDTH, 1) view:view];
    
    
    wybtn1=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 100, view.frame.size.width-10, 50) title:@"请选择您要报修的类别" select:@selector(Action:) Tag:1 View:view textColor:gray Size:font14 background:nil];
    wybtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(wybtn1.frame.size.width-30,15, 20, 20) View:wybtn1 Tag:1];

    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 150, SCREEN_WIDTH, 1) view:view];

    
    wybtn2=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 150, view.frame.size.width-10, 50) title:@"请选择报修地址信息" select:@selector(Action:) Tag:2 View:view textColor:gray Size:font14 background:nil];
    wybtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(wybtn2.frame.size.width-30,15, 20, 20) View:wybtn2 Tag:1];

    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 200, SCREEN_WIDTH, 1) view:view];
    
    
    lpText=[LSFUtil addTextView:CGRectMake(10, 220, view.frame.size.width-20, 80) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"您需要的服务及遇到的情况" View:view font:font14];
    
    picScr=[LSFUtil add_scollview:CGRectMake(10,320, SCREEN_WIDTH-20,110) Tag:1 View:view co:CGSizeMake(0, SCREEN_HEIGHT)];

    [self reloadScrollView];
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20,BottomHeight,SCREEN_WIDTH-40, 40) title:@"提交" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;

    
}

-(void)Action:(UIButton*)btn{

    if(btn.tag==3){
    
        if(usernameText.text.length==0){
        
            [self showHint:@"请输入称呼"];
            return;
        
        }
        if(![LSFEasy validateMobile:phoneText.text]){
        
            
            [self showHint:@"手机号格式不正确"];
            return;
        
        }
        if([wybtn1.titleLabel.text isEqualToString:@"请选择您要报修的类别"]){
        
            
            [self showHint:@"请选择您要报修的类别"];
            return;
        
        }
        if([wybtn2.titleLabel.text isEqualToString:@"请选择报修地址信息"]){
            
            
            [self showHint:@"请选择报修地址信息"];
            return;
        }
        if(lpText.text.length==0){
        
            [self showHint:@"请输入您需要的服务及遇到的情况"];
            return;
        }
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"property_insert"];
        [api property_insert:typeId addressId:addressId content:lpText.text parentId:[LSFEasy isEmpty:ParentId]?@"":ParentId size:picArray.count picArray:picArray];
        
    }
    else if (btn.tag==2) {
    
        GetUserAddressViewController * address =[[GetUserAddressViewController alloc] init];
        address.completeBlockNSDictionary=^(NSDictionary*dic){
        
            addressId=dic[@"id"];
            NSString * str=[NSString stringWithFormat:@"%@%@%@%@%@栋%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"region"][@"name"],dic[@"cell"][@"name"],dic[@"buildingname"],dic[@"roomname"]];
            
            [wybtn2 setTitle:str forState:normal];
            
        };
        
        [self.navigationController pushViewController:address animated:YES];
        
    
    }
    else{
    
        BaoXiuTypeViewController * address =[[BaoXiuTypeViewController alloc] init];
        address.completeBlockNSDictionary=^(NSDictionary*dic){
            
            typeId=dic[@"id"];
            [wybtn1 setTitle:dic[@"name"] forState:normal];
        };
        
        [self.navigationController pushViewController:address animated:YES];
    
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadScrollView{
    
    [picScr.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
            [picScr addSubview:btn];
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
            [picScr addSubview:imgView];
        }
        
    }
    picScr.contentSize = CGSizeMake((wid + 10) * arr.count + 10, 0);
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
    // 选择图片的最小数，默认是9张图片最大也是9张
    pickerVc.maxCount = 4 - picArray.count;
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
            NSData * imagedata = UIImageJPEGRepresentation(originalImage,0.5f);
            [picArray addObject:imagedata];
        }
    }
    
    [self reloadScrollView];

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
    
    WXListViewController * wx=[[WXListViewController alloc] init];
    [self.navigationController pushViewController:wx animated:YES];
    
}


@end
