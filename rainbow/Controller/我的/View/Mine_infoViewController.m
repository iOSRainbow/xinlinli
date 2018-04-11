//
//  Mine_infoViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_infoViewController.h"
#import "Mine_nickNameViewController.h"
#import "Mine_SexViewController.h"
#import "Mine_birthViewController.h"
#import "Mine_PasswordViewController.h"
#import "Mine_iphonViewController.h"

@interface Mine_infoViewController ()

@end

@implementation Mine_infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"个人资料"];
    
    tableArray =[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0,NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];


    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findByUserId"];
    [api findByUserId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if(indexPat.row==0){
    
        return 80;
    }
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-20,indexPath.row==0?30:15, 20, 20) View:indexPath.row==5?nil:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20, 0, SCREEN_WIDTH-50, indexPath.row==0?80:50) View:cell Alignment:0 Color:black Tag:2];
        
        UILabel*line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(20, indexPath.row==0?79:49, SCREEN_WIDTH, 1) view:cell];
        line.tag=3;
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 0, SCREEN_WIDTH-30, 50) View:cell Alignment:2 Color:black Tag:4];
        
       UIImageView * headImg= [LSFUtil addSubviewImage:nil rect:CGRectMake(SCREEN_WIDTH-90, 10, 60, 60) View:cell Tag:5];
        headImg.layer.cornerRadius=30;
        headImg.layer.masksToBounds=YES;
        
    }
    
    
    UILabel * lable =(UILabel*)[cell viewWithTag:2];
    UILabel *line =(UILabel*)[cell viewWithTag:3];
    UILabel *info =(UILabel*)[cell viewWithTag:4];
    UIImageView * img=(UIImageView*)[cell viewWithTag:5];
    
    
    info.hidden=indexPath.row==0?YES:NO;
    img.hidden=indexPath.row==0?NO:YES;
    
    if(indexPath.row==0){
    
    info.text=@"";
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,tableArray[indexPath.row]]] placeholderImage:nil];
    
    }else{
    
        info.text=tableArray[indexPath.row];
        img.image=nil;
    }
    
    
    
    lable.text=dataArray[indexPath.row];
    line.hidden=(indexPath.row==5)?YES:NO;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
    
        UIAlertController*  alertView=[UIAlertController alertControllerWithTitle:@"请选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self didPhoto];
        }];
        UIAlertAction *actionPhoto=[UIAlertAction actionWithTitle:@"本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self chooseLocalPhoto];
            
        }];
        UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertView dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertView addAction:actionCamera];
        [alertView addAction:actionPhoto];
        [alertView addAction:actionCancel];
        
        [self presentViewController:alertView animated:YES completion:nil];
        

    
    }
    else if (indexPath.row==1){
    
        Mine_nickNameViewController * nick=[[Mine_nickNameViewController alloc] init];
        
        nick.name=tableArray[indexPath.row];
        
        nick.completeBlockNSString=^(NSString * name){
        
            [tableArray replaceObjectAtIndex:1 withObject:name];
            TABLERELOAD(tableview, 1, 0);
        };
        
        [self.navigationController pushViewController:nick animated:YES];
    }
    else if (indexPath.row==2){
    
        Mine_SexViewController * sex =[[Mine_SexViewController alloc] init];
        sex.SexStr=tableArray[indexPath.row];
        sex.completeBlockNSString=^(NSString * sexName){
        
            [tableArray replaceObjectAtIndex:2 withObject:sexName];
            TABLERELOAD(tableview, 2, 0);
        };
        [self.navigationController pushViewController:sex animated:YES];
    
    }
    else if (indexPath.row==3){
    
        Mine_birthViewController * birth =[[Mine_birthViewController alloc] init];
        birth.birthStr=tableArray[indexPath.row];
        birth.completeBlockNSString=^(NSString * birth){
            
            [tableArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@",birth]];
            TABLERELOAD(tableview, 3, 0);
        };
        [self.navigationController pushViewController:birth animated:YES];
    
    
    }
    else if (indexPath.row==4){
    
        Mine_PasswordViewController * password=[[Mine_PasswordViewController alloc] init];
        
        [self.navigationController pushViewController:password animated:YES];
    
    }
 
}


//拍照
-(void)didPhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//本地
-(void)chooseLocalPhoto
{
    UIImagePickerController *imagePicker  = [[UIImagePickerController alloc] init];
    imagePicker.delegate =self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing =YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
//对图片尺寸进行压缩--
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info

{
    //UIImagePickerControllerOriginalImage
    //初始化imageNew为从相机中获得的--
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //设置image的尺寸
    
    [self showHudInView:self.view hint:@"加载中"];
    
    Api * api =[[Api alloc] init:self tag:@"uploadHeadpic"];
    [api uploadHeadpic:imageNew];

    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    if([tag isEqualToString:@"uploadHeadpic"]){
       
       [self showHint:response[@"msg"]];

    
    
    }else if ([tag isEqualToString:@"findByUserId"]){
    
    
        dataArray=[[NSMutableArray alloc] initWithObjects:@"头像",@"昵称",@"性别",@"生日",@"修改密码",@"已绑定手机", nil];

        NSDictionary * dic=response[@"data"];
        
        [tableArray addObject:[LSFEasy isEmpty:dic[@"headpic"]]?@"":dic[@"headpic"]];
        [tableArray addObject:[LSFEasy isEmpty:dic[@"realname"]]?@"未设置":dic[@"realname"]];
        [tableArray addObject:[dic[@"gender"] integerValue]==1?@"男":@"女"];
        [tableArray addObject:[LSFEasy isEmpty:dic[@"birthday"]]?@"未设置":dic[@"birthday"]];
        [tableArray addObject:@""];
        [tableArray addObject:dic[@"username"]];

        [tableview reloadData];
    }

    

}
@end
