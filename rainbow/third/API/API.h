//
//  Api.h
//  HttpWithCacheDemo
//
//  Created by 大有 on 16/6/7.
//  Copyright © 2016年 大有. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpRequestWithCache.h"

@interface Api : NSObject

@property (nonatomic,strong)  HttpRequestWithCache *httpRequest;

#pragma mark - init方法
//无需token
-(instancetype)init:(id)delegate tag:(NSString *)tag;
//携带token
-(instancetype)init:(id)delegate tag:(NSString *)tag NeedToken:(NSInteger)NeedToken;


-(void)login:(NSString*)Username Password:(NSString*)Password;

-(void)findCellInfo:(NSString*)cellId;

-(void)indexPhoto_banner;

-(void)adminInfo;

-(void)findByUserId;

-(void)changeRealName:(NSString*)realname;

-(void)uploadHeadpic:(UIImage*)pic;

-(void)changeBirthday:(NSString*)birthday;

-(void)findSubUsers;

-(void)getGifts;

-(void)changeGender:(NSString*)gender;

-(void)changePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;

-(void)address_findByUserId;

-(void)gifPost:(NSString*)giftId name:(NSString*)name phone:(NSString*)phone cell:(NSString*)cell address:(NSString*)address;

-(void)giftRecord;


-(void)deleteAddressWithUserId:(NSString*)addressId;

-(void)giftExchange:(NSString*)giftId;

-(void)sign;

-(void)pointsCountByUserId;

-(void)assignList;


-(void)findAllProvinces;

-(void)findCitysByProvinceId:(NSString*)provinceId;

-(void)findRegionsByCityId:(NSString*)cityId;

-(void)findCellsByRegionId:(NSString*)regionId;

-(void)insertAddressWithUserId:(NSString*)cell buildingname:(NSString*)buildingname roomname:(NSString*)roomname;

-(void)updateDefaultAddress:(NSString*)addressId;


-(void)getCode:(NSString*)username;

-(void)insertSubUser:(NSString*)username password:(NSString*)password yzm:(NSString*)yzm yzm1:(NSString*)yzm1;

-(void)deleteSubUser:(NSString*)subUserId;


-(void)cellInfo;

-(void)findAllpropertytype;

-(void)findCanUseByuserId;

-(void)property_insert:(NSString*)propertytypeId addressId:(NSString*)addressId content:(NSString*)content parentId:(NSString*)parentId size:(NSInteger)size picArray:(NSMutableArray *)picArray;


-(void)findPropertyCustomsByUserId;

-(void)findById:(NSString*)propertyId;

-(void)deleteProperty:(NSString*)propertyId;

-(void)user_register:(NSString*)username password:(NSString*)password yzm:(NSString*)yzm yzm1:(NSString*)yzm1;

-(void)getCodePassword:(NSString*)username;

-(void)pubTopic:(NSString*)title content:(NSString*)content size:(NSInteger)size picArray:(NSMutableArray*)picArray;


-(void)info_findById:(NSString*)tipId;

-(void)topic_pritopicList:(NSInteger)index;

-(void)topic_findPriById:(NSString*)friendId;

-(void)topic_praisePritopic:(NSString*)friendId;


-(void)topic_repTopic:(NSString*)content pariparentId:(NSString*)pariparentId;



-(void)topic_repSubtopic:(NSString*)title content:(NSString*)content pariparentId:(NSString*)pariparentId parantId:(NSString*)parantId;


-(void)topic_praiseSubtopic:(NSString*)friendId;


-(void)resetPassword:(NSString *)username password:(NSString*)password password1:(NSString*)password1 yzm:(NSString*)yzm yzm1:(NSString*)yzm1;



-(void)zfb_pay:(NSString*)money type:(NSString*)type;


#warning 临时测试
-(void)zfb_pay2:(NSString*)money type:(NSString*)type;

/*
 type         家电服务类型
 （比如电脑维修，电视维修）
 由前段写死
 user_id       用户id
 address_id    地址ID
 content       家电描述
 price         价格
 priceDetail   可以不提交
 orderTime     预约时间

 /app/order/insert.do
 */

-(void)order_insert:(NSString*)name tel:(NSString*)tel address:(NSString*)address goodsname:(NSString*)goodsname servicetime:(NSString*)servicetime msg:(NSString*)msg price:(NSString*)price payment:(NSString*)payment zfbno:(NSString*)zfbno voucherId:(NSString*)voucherId vouchercellId:(NSString*)vouchercellId realprice:(NSString*)realprice goodscateId:(NSString*)goodscateId amount:(NSString*)amount;


-(void)orderList;


-(void)sureOrder:(NSString*)orderId;

-(void)cancelOrder:(NSString*)orderId;


-(void)cellpayDetail:(NSString*)building cellId:(NSString*)cellId;


///app/cellpay/cellpayList.do
-(void)cellpayList;

///app/cellpay/insert.do
/*
 userId,
 addressId,缴费地址id
 price,金额
 months月数
 */
-(void)cellpay_insert:(NSString*)addressId price:(NSString*)price months:(NSString*)months;


///app/coupon/couponList.do
-(void)couponList:(NSString*)fromView;


///app/coupon/insert.do
/*
 userId 用户id，
 couponId 优惠券Id，
 addressId 地址id
 */
-(void)coupon_insert:(NSString*)addressId couponId:(NSString*)couponId fromView:(NSString*)fromView;
///app/coupon/couporderList.do
-(void)couporderList:(NSString*)fromView;

///app/zfb/cellpay.do
-(void)zfb_cellpay:(NSString*)money cellId:(NSString*)cellId;



-(void)goods_goods:(NSInteger)typeId;

-(void)goods_goodstypelist;

-(void)goods_goodslist:(NSString*)typeId;

-(void)goods_goodsdetail:(NSString*)goodsId;

-(void)comment_list:(NSString*)goodsId;

-(void)comment_addComment:(NSString*)goodsId content:(NSString*)content orderId:(NSString*)orderId state:(NSString*)state;


///app/vip/vipuser.do
-(void)vip_vipuser;

///app/vip/version.do
-(void)vip_viersion;

//会员充值
-(void)vip_recharge:(NSString*)money sn:(NSString*)sn addition:(NSString*)addition;

-(void)vip_vipactivate:(NSString*)password type:(NSInteger)type;


#pragma mark 修改门禁密码
-(void)doorinfo_update:(NSString*)doorId password:(NSString*)password;


#pragma mark 获取门禁密码
-(void)doorinfo_getPassword:(NSString*)doorId;


#pragma mark 门禁地址列表
-(void)address_findDoorinfo;


#pragma mark 抵用卷列表
-(void)app_offset_list;



#pragma mark 登陆限制
-(void)app_user_getTime;


///app/goods/loglist.do
-(void)app_goods_loglist;


///app/indexPhoto/index.do
-(void)app_indexPhoto_index;

-(void)app_prizes_getPrizesData;

-(void)app_prizes_setPrizesData;


-(void)app_prizes_receivePrizesData;

//家政维护首页
-(void)goods_jjfwIndex;

//搜素
-(void)goods_search:(NSString*)goodsName;


//收货地址接口
-(void)goodsAddress_findByUserId;

//新增收货地址
-(void)goodsaddress_add:(NSString*)name tel:(NSString*)tel address:(NSString*)address;


//修改收货地址
-(void)goodsaddress_edit:(NSString*)name tel:(NSString*)tel address:(NSString*)address addressId:(NSString*)addressId;


//删除收货地址
-(void)goodsaddress_delete:(NSString*)addressId;


//提交订单厨师数据
-(void)orders_addUI:(NSString*)goodsId;

/*
 
1、app/usercard/list.do上传userId获取绑定的列表                                     2、app/usercard/add.do上传userId，cardno2(输入的卡号)，进行绑定     3、app/usercard/loss.do上传id(list.do接口获取的id)，进行挂失，里面有个status如果是1，就是绑定成功，如果是2就是挂失成功，所以在list页面，判断这个值，来设置挂失键是否可点击，可点击时最好挑个弹窗让用户在确认一下，因为这个操作不可逆
*/

//进行绑定
-(void)usercard_add:(NSString*)cardno2;

//获取绑定的列表
-(void)usercard_list;

//挂失
-(void)usercard_loss:(NSString*)cardId;


//加入购物车
-(void)shoppingcar_addCar:(NSString*)goodId message:(NSString*)message count:(NSInteger)count;


//购物车列表
-(void)shoppingcar_carList;


//删除购物车得商品
-(void)shoppingcar_deleteCar:(NSString*)goodId;


//修改购物车-商品数量
-(void)shoppingcar_updateCar:(NSString*)goodId message:(NSString*)message count:(NSInteger)count;

//查看是否有抽奖资格
-(void)cash_scanner:(NSString*)qrcode;

//领取抽奖
-(void)cash_exchange:(NSDictionary*)dict;

//我的电瓶首页数据
-(void)battery_getUserbatterybyUserId;

//获取押金列表
-(void)battery_getbatteryTypeList;

//支付押金
-(void)battery_addDeposit:(NSString*)deposit;

//支付租金
-(void)battery_addRent:(NSString*)year;

//获取更换记录
-(void)battery_getOldBatteryList;

//退押金
-(void)battery_returnDeposit;

//更换电池扫一扫获取数据
-(void)battery_scan:(NSString*)number year:(NSString*)year;

//支付更换电池费用
-(void)battery_exchange:(NSString*)number year:(NSString*)year;
@end
