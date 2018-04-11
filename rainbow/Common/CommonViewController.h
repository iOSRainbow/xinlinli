//
//  CommonViewController.h
//  deyingSoft
//
//  Created by GuiDaYou on 16/1/23.
//  Copyright © 2016年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CommonViewController : UIViewController
{
    UIView *navView,*emptyView;
    
    UIButton *navLeftBtn,*navRightBtn;
    
    UILabel *navTitleLable;
    BOOL isModal;//是否是模态视图
    
    NSInteger pageIndex,pageSize;
    
}

#pragma mark - 设置Vc的title
-(void)setNavTitle:(NSString *)title;

#pragma mark - 添加导航栏左右按钮的方法(文本和图片)
-(void)addNavLeftBtnWithTitle:(NSString *)title;
-(void)addNavLeftBtnWithTitle:(NSString *)title rect:(CGRect)rect;
-(void)addNavRightBtnWithTitle:(NSString *)title;
-(void)addNavRightBtnWithTitle:(NSString *)title rect:(CGRect)rect;
-(void)addNavRightBtnWithTitle:(NSString *)title color:(UIColor *)color;
-(void)addNavRightBtnWithTitle:(NSString *)title color:(UIColor *)color rect:(CGRect)rect;

-(void)addNavLeftBtnWithImage:(NSString *)image rect:(CGRect)rect;
-(void)addNavLeftBtnWithImage:(NSString *)image;
-(void)addNavRightBtnWithImage:(NSString *)image rect:(CGRect)rect;
-(void)addNavRightBtnWithImage:(NSString *)image;


#pragma mark - 导航栏2边按钮的响应处理方法
-(void)actNavLeftBtn;
-(void)actNavRightBtn;

//UIButton
-(UIButton*)buttonPhotoAlignment:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title  select:(SEL)sel Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size background:(UIColor *)background;

#pragma mark -几个参数block
@property (nonatomic,copy)  void(^completeBlockNone)();
@property (nonatomic,copy)  void(^completeBlockNSString)(NSString *completeStr);
@property (nonatomic,copy)  void(^completeBlockNSArray)(NSArray *completeAry);
@property (nonatomic,copy)  void(^completeBlockNSDictionary)(NSDictionary *completedic);
@property (nonatomic,copy)  void(^completeBlockMutableArray)(NSMutableArray *completeAry);

@end
