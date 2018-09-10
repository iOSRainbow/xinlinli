//
//  Api.m
//  HttpWithCacheDemo
//
//  Created by 大有 on 16/6/7.
//  Copyright © 2016年 大有. All rights reserved.
//

#import "Api.h"
@implementation Api
@synthesize httpRequest;

#pragma mark - init方法
//无需token
-(instancetype)init:(id)delegate tag:(NSString *)tag
{
    return [self init:delegate tag:tag NeedToken:0];
}

//携带token
-(instancetype)init:(id)delegate tag:(NSString *)tag NeedToken:(NSInteger)NeedToken
{
    if (self=[super init]) {
        httpRequest=[[HttpRequestWithCache alloc]initWithDelegate:delegate bindTag:tag NeedToken:NeedToken];
    }
    return self;
}




-(void)login:(NSString*)Username Password:(NSString*)Password{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:Username forKey:@"username"];
    [params setObject:Password forKey:@"password"];
    [httpRequest httpPostRequest:@"app/user/login.do" params:params];

}

-(void)indexPhoto_banner{

    [httpRequest httpPostRequest:@"app/indexPhoto/banner.do" params:nil];

}

-(void)adminInfo{

    [httpRequest httpPostRequest:@"app/info/adminInfo.do" params:nil];

}


-(void)findByUserId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/user/findByUserId.do" params:params];
}

-(void)changeRealName:(NSString*)realname{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:realname forKey:@"realname"];
    [httpRequest httpPostRequest:@"app/user/changeRealName.do" params:params];
}


-(void)changeBirthday:(NSString*)birthday{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:birthday forKey:@"birthday"];
    [httpRequest httpPostRequest:@"app/user/changeBirthday.do" params:params];

}
-(void)uploadHeadpic:(UIImage*)pic{
  
    NSData *_data = UIImageJPEGRepresentation(pic, 0.5f);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest upLoadDataWithUrlStr:@"app/user/uploadHeadpic.do" params:params imageKey:@"file" withData:_data];

}




-(void)findSubUsers{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/user/findSubUsers.do" params:params];

}


-(void)getGifts{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/gift/getGifts.do" params:params];
}

-(void)changeGender:(NSString*)gender{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:gender forKey:@"gender"];
    [httpRequest httpPostRequest:@"app/user/changeGender.do" params:params];
}


-(void)changePassword:(NSString*)oldPassword newPassword:(NSString*)newPasswor{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:oldPassword forKey:@"oldPassword"];
    [params setObject:newPasswor forKey:@"newPassword"];
    [httpRequest httpPostRequest:@"app/user/changePassword.do" params:params];
}



-(void)address_findByUserId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/address/findByUserId.do" params:params];
}

-(void)findCellInfo:(NSString*)cellId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:cellId forKey:@"cellId"];

    [httpRequest httpPostRequest:@"app/address/findCellInfo.do" params:params];

}


-(void)gifPost:(NSString*)giftId name:(NSString*)name phone:(NSString*)phone cell:(NSString*)cell address:(NSString*)address{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:giftId forKey:@"giftId"];
    [params setObject:name forKey:@"name"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:cell forKey:@"cell"];
    [params setObject:address forKey:@"address"];
    [params setObject:TOKEN forKey:@"userId"];

    [httpRequest httpPostRequest:@"app/gift/giftPost.do" params:params];
    

}


-(void)giftRecord{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/points/giftRecord.do" params:params];
}


-(void)deleteAddressWithUserId:(NSString*)addressId{

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:addressId forKey:@"addressId"];

    [httpRequest httpPostRequest:@"app/address/deleteAddressWithUserId.do" params:params];
}


-(void)giftExchange:(NSString*)giftId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:giftId forKey:@"giftId"];

    [httpRequest httpPostRequest:@"app/gift/giftExchange.do" params:params];

}

-(void)sign{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/user/sign.do" params:params];
}


-(void)pointsCountByUserId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/points/pointsCountByUserId.do" params:params];
}


-(void)assignList{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/assign/assignList.do" params:params];
}

-(void)findAllProvinces{
    [httpRequest httpPostRequest:@"common/findAllProvinces.do" params:nil];
}



-(void)findCitysByProvinceId:(NSString*)provinceId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:provinceId forKey:@"provinceId"];
    [httpRequest httpPostRequest:@"common/findCitysByProvinceId.do" params:params];
}

-(void)findRegionsByCityId:(NSString*)cityId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:cityId forKey:@"cityId"];
    [httpRequest httpPostRequest:@"common/findRegionsByCityId.do" params:params];
}

-(void)findCellsByRegionId:(NSString*)regionId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:regionId forKey:@"regionId"];
    [httpRequest httpPostRequest:@"common/findCellsByRegionId.do" params:params];
}

-(void)insertAddressWithUserId:(NSString*)cell buildingname:(NSString*)buildingname roomname:(NSString*)roomname{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:cell forKey:@"cellId"];
    [params setObject:buildingname forKey:@"buildingname"];
    [params setObject:roomname forKey:@"roomname"];

    [httpRequest httpPostRequest:@"app/address/insertAddressWithUserId.do" params:params];
}


-(void)updateDefaultAddress:(NSString*)addressId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:addressId forKey:@"addressId"];
    
    [httpRequest httpPostRequest:@"app/address/updateDefaultAddress.do" params:params];
}

-(void)getCode:(NSString*)username{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    
    [httpRequest httpPostRequest:@"common/getCode.do" params:params];
}


-(void)insertSubUser:(NSString*)username password:(NSString*)password yzm:(NSString*)yzm yzm1:(NSString*)yzm1{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    [params setObject:yzm1 forKey:@"yzm1"];
    [params setObject:yzm forKey:@"yzm"];
    [httpRequest httpPostRequest:@"app/user/insertSubUser.do" params:params];

}


-(void)deleteSubUser:(NSString*)subUserId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:subUserId forKey:@"subUserId"];
    [httpRequest httpPostRequest:@"app/user/deleteSubUser.do" params:params];

}

-(void)cellInfo{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/info/cellInfo.do" params:params];
}


-(void)findAllpropertytype{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/property/findAllPropertytype.do" params:params];
}

-(void)findCanUseByuserId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/address/findCanUseByUserId.do" params:params];
}


-(void)property_insert:(NSString*)propertytypeId addressId:(NSString*)addressId content:(NSString*)content parentId:(NSString*)parentId size:(NSInteger)size picArray:(NSMutableArray *)picArray{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:propertytypeId forKey:@"propertytypeId"];
    [params setObject:addressId forKey:@"addressId"];
    [params setObject:content forKey:@"content"];
    [params setObject:parentId forKey:@"parentId"];
    [params setObject:[NSNumber numberWithInteger:size] forKey:@"size"];
    [httpRequest upLoadDataWithUrlStr:@"app/property/insert.do" params:params withDataArray:picArray];

}



-(void)findPropertyCustomsByUserId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/property/findPropertyCustomsByUserId.do" params:params];
}


-(void)findById:(NSString*)propertyId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:propertyId forKey:@"id"];

    [httpRequest httpPostRequest:@"app/property/findById.do" params:params];
}


-(void)deleteProperty:(NSString*)propertyId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:propertyId forKey:@"propertyId"];
    
    [httpRequest httpPostRequest:@"app/property/deleteProperty.do" params:params];

}

-(void)user_register:(NSString*)username password:(NSString*)password yzm:(NSString*)yzm yzm1:(NSString*)yzm1{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    [params setObject:yzm forKey:@"yzm"];
    [params setObject:yzm1 forKey:@"yzm1"];

    [httpRequest httpPostRequest:@"app/user/register.do" params:params];

}


-(void)getCodePassword:(NSString*)username{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    
    [httpRequest httpPostRequest:@"common/getCodePassword.do" params:params];
}



-(void)pubTopic:(NSString*)title content:(NSString*)content size:(NSInteger)size picArray:(NSMutableArray *)picArray{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:CellId forKey:@"cellId"];
    [params setObject:[NSNumber numberWithInteger:size] forKey:@"size"];

    [httpRequest upLoadDataWithUrlStr:@"app/topic/pubTopic.do" params:params withDataArray:picArray];

}


-(void)info_findById:(NSString*)tipId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:tipId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/info/findById.do" params:params];
}


-(void)topic_pritopicList:(NSInteger)index{

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:ParentId forKey:@"parentId"];
    [params setObject:[NSNumber numberWithInteger:index] forKey:@"index"];
    [httpRequest httpPostRequest:@"app/topic/pritopicList.do" params:params];
    
    
}


-(void)topic_findPriById:(NSString*)friendId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:friendId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/topic/findPriById.do" params:params];
}


-(void)topic_praisePritopic:(NSString*)friendId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:friendId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/topic/praisePritopic.do" params:params];
}



-(void)topic_repTopic:(NSString*)content pariparentId:(NSString*)pariparentId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:pariparentId forKey:@"priparentId"];
    [params setObject:content forKey:@"content"];
    [httpRequest httpPostRequest:@"app/topic/repTopic.do" params:params];
}


-(void)topic_repSubtopic:(NSString*)title content:(NSString*)content pariparentId:(NSString*)pariparentId parantId:(NSString*)parantId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:parantId forKey:@"parentId"];
    [params setObject:content forKey:@"content"];
    [params setObject:title forKey:@"title"];
    [params setObject:pariparentId forKey:@"priparentId"];
    [httpRequest httpPostRequest:@"app/topic/repSubtopic.do" params:params];
}


-(void)topic_praiseSubtopic:(NSString*)friendId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:friendId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/topic/praiseSubtopic.do" params:params];

}


-(void)resetPassword:(NSString *)username password:(NSString*)password password1:(NSString*)password1 yzm:(NSString*)yzm yzm1:(NSString*)yzm1{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    [params setObject:yzm forKey:@"yzm"];
    [params setObject:yzm1 forKey:@"yzm2"];
    [params setObject:password forKey:@"password1"];
    [params setObject:password1 forKey:@"password2"];
    [httpRequest httpPostRequest:@"common/resetPassword.do" params:params];


}


-(void)zfb_pay:(NSString*)money type:(NSString*)type{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:type forKey:@"type"];
    [params setObject:money forKey:@"money"];
    [httpRequest httpPostRequest:@"app/zfb/pay.do" params:params];
}


#warning 临时测试
-(void)zfb_pay2:(NSString*)money type:(NSString*)type{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:type forKey:@"type"];
    [params setObject:money forKey:@"money"];
    [httpRequest httpPostRequest:@"app/zfb/pay2.do" params:params];
}



-(void)order_insert:(NSString*)name tel:(NSString*)tel address:(NSString*)address goodsname:(NSString*)goodsname servicetime:(NSString*)servicetime msg:(NSString*)msg price:(NSString*)price payment:(NSString*)payment zfbno:(NSString*)zfbno voucherId:(NSString*)voucherId vouchercellId:(NSString*)vouchercellId realprice:(NSString*)realprice goodscateId:(NSString*)goodscateId amount:(NSString*)amount{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:name forKey:@"name"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:address forKey:@"address"];
    [params setObject:goodsname forKey:@"goodsname"];
    [params setObject:servicetime forKey:@"servicetime"];
    [params setObject:msg forKey:@"msg"];
    //record
    [params setObject:price forKey:@"price"];
    [params setObject:payment forKey:@"payment"];
    [params setObject:zfbno forKey:@"zfbno"];
    [params setObject:voucherId forKey:@"voucherId"];
    [params setObject:vouchercellId forKey:@"vouchercellId"];
    [params setObject:realprice forKey:@"realprice"];
    [params setObject:goodscateId forKey:@"goodscateId"];
    [params setObject:amount forKey:@"amount"];

    [httpRequest httpPostRequest:@"app/orders/add.do" params:params];
 

}


-(void)orderList{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/orders/query.do" params:params];

}



///app/order/sureOrder.do
-(void)sureOrder:(NSString*)orderId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:orderId forKey:@"id"];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/orders/confirm.do" params:params];

}
///app/order/cancelOrder.do
-(void)cancelOrder:(NSString*)orderId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:orderId forKey:@"id"];
    [params setObject:TOKEN forKey:@"userId"];

    [httpRequest httpPostRequest:@"app/orders/cancel.do" params:params];
}



-(void)cellpayDetail:(NSString*)building cellId:(NSString*)cellId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:building forKey:@"building"];
    [params setObject:cellId forKey:@"cellId"];

    [httpRequest httpPostRequest:@"app/cellpay/cellpayDetail.do" params:params];
}



///app/cellpay/cellpayList.do
-(void)cellpayList{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/cellpay/cellpayList.do" params:params];

}

///app/cellpay/insert.do
/*
 userId,
 addressId,缴费地址id
 price,金额
 months月数
 */
-(void)cellpay_insert:(NSString*)addressId price:(NSString*)price months:(NSString*)months{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:addressId forKey:@"addressId"];
    [params setObject:months forKey:@"months"];
    [params setObject:price forKey:@"price"];
    [params setObject:@"1" forKey:@"record"];

    [httpRequest httpPostRequest:@"app/cellpay/insert.do" params:params];
    

}


///app/coupon/couponList.do
-(void)couponList:(NSString*)fromView{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/coupon/sendCouponList.do" params:params];

}


///app/coupon/insert.do
/*
 userId 用户id，
 couponId 优惠券Id，
 addressId 地址id
 */
-(void)coupon_insert:(NSString*)addressId couponId:(NSString*)couponId fromView:(NSString*)fromView{


    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:addressId forKey:@"addressId"];
    [params setObject:couponId forKey:@"couponId"];

    [httpRequest httpPostRequest:@"app/coupon/userVipCoupon.do" params:params];
}
///app/coupon/couporderList.do
-(void)couporderList:(NSString*)fromView{

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/coupon/vipOrderList.do" params:params];
}


///app/zfb/cellpay.do
-(void)zfb_cellpay:(NSString*)money cellId:(NSString*)cellId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:money forKey:@"money"];
    [params setObject:cellId forKey:@"cellId"];
    [httpRequest httpPostRequest:@"app/zfb/cellpay.do" params:params];

}



-(void)goods_goods:(NSInteger)typeId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:typeId] forKey:@"typeId"];
    [httpRequest httpPostRequest:@"app/goods/goods.do" params:params];
}

-(void)goods_jjfwIndex{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     [params setObject:TOKEN forKey:@"userId"];
     [httpRequest httpPostRequest:@"app/goods/jjfwIndex.do" params:params];
}


-(void)goods_goodstypelist{

   NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/goods/findPcateId.do" params:params];

}


-(void)goods_goodslist:(NSString*)typeId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:typeId forKey:@"id"];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/goods/findByPcateId.do" params:params];

}

-(void)goods_goodsdetail:(NSString*)goodsId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:goodsId forKey:@"id"];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/goods/findByCateId.do" params:params];

}
-(void)comment_list:(NSString*)goodsId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:goodsId forKey:@"goodscateId"];
    [params setObject:TOKEN forKey:@"userId"];

    [httpRequest httpPostRequest:@"app/goods/moreGoodsComment.do" params:params];
}


-(void)comment_addComment:(NSString*)goodsId content:(NSString*)content orderId:(NSString*)orderId state:(NSString*)state{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodsId forKey:@"goodscateId"];
    [params setObject:orderId forKey:@"orderId"];
    [params setObject:content forKey:@"detail"];
    [params setObject:state forKey:@"satis"];
    [httpRequest httpPostRequest:@"app/goods/addGoodsComment.do" params:params];

}

///app/vip/vipuser.do
-(void)vip_vipuser{
   
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/memberdegree/findByUserId.do" params:params];

}


///app/vip/version.do
-(void)vip_viersion{

    [httpRequest httpPostRequest:@"app/vip/version.do" params:nil];
}
//app/vip/recharge.do
-(void)vip_recharge:(NSString*)money sn:(NSString*)sn addition:(NSString*)addition{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:money forKey:@"amount"];
    [params setObject:sn forKey:@"sn"];
    [params setObject:addition forKey:@"addition"];

    [httpRequest httpPostRequest:@"app/money/addZfb.do" params:params];
}

-(void)vip_vipactivate:(NSString*)password type:(NSInteger)type{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:password forKey:type==1?@"id":@"cardno"];
    [httpRequest httpPostRequest:type==1?@"app/redeem/add.do":@"app/money/addRefillcard.do" params:params];
}


#pragma mark 修改门禁密码
-(void)doorinfo_update:(NSString*)doorId password:(NSString*)password{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:doorId forKey:@"id"];
    [params setObject:password forKey:@"password"];

    [httpRequest httpPostRequest:@"app/doorinfo/update.do" params:params];

}


#pragma mark 获取门禁密码
-(void)doorinfo_getPassword:(NSString*)doorId{

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:doorId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/doorinfo/getPassword.do" params:params];
}


#pragma mark 门禁地址列表
-(void)address_findDoorinfo{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/address/findDoorinfo.do" params:params];
}
#pragma mark 抵用卷列表
-(void)app_offset_list{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/voucher/findAll.do" params:params];
}


#pragma mark 登陆限制
-(void)app_user_getTime{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/user/getTime.do" params:params];

}

//首页最下方列表数据
-(void)app_goods_loglist{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/goods/index.do" params:params];

}


///app/indexPhoto/index.do
-(void)app_indexPhoto_index{
    
    
    [httpRequest httpPostRequest:@"app/indexPhoto/index.do" params:nil];
}

-(void)app_prizes_getPrizesData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/ninePrizes/getPrizesData.do" params:params];
}
-(void)app_prizes_receivePrizesData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/ninePrizes/receivePrize.do" params:params];
}
-(void)app_prizes_setPrizesData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/ninePrizes/setPrizesData.do" params:params];
}


//搜素
-(void)goods_search:(NSString*)goodsName{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodsName forKey:@"goodsName"];

    [httpRequest httpPostRequest:@"app/goods/search.do" params:params];
}



//收货地址接口
-(void)goodsAddress_findByUserId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/goodsaddress/findByUserId.do" params:params];
    
}


//新增收货地址
-(void)goodsaddress_add:(NSString*)name tel:(NSString*)tel address:(NSString*)address{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:name forKey:@"name"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:address forKey:@"address"];

    [httpRequest httpPostRequest:@"app/goodsaddress/add.do" params:params];
}


//修改收货地址
-(void)goodsaddress_edit:(NSString*)name tel:(NSString*)tel address:(NSString*)address addressId:(NSString*)addressId{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:name forKey:@"name"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:address forKey:@"address"];
    [params setObject:addressId forKey:@"id"];

    [httpRequest httpPostRequest:@"app/goodsaddress/edit.do" params:params];
}


//删除收货地址
-(void)goodsaddress_delete:(NSString*)addressId{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:addressId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/goodsaddress/delete.do" params:params];
}



//提交订单厨师数据
-(void)orders_addUI:(NSString*)goodsId{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodsId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/orders/addUI.do" params:params];
}

//进行绑定
-(void)usercard_add:(NSString*)cardno2{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:cardno2 forKey:@"cardno2"];
    [httpRequest httpPostRequest:@"app/usercard/add.do" params:params];
}

//获取绑定的列表
-(void)usercard_list{
 
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/usercard/list.do" params:params];
}

//挂失
-(void)usercard_loss:(NSString*)cardId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:cardId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/usercard/loss.do" params:params];
}


//加入购物车
-(void)shoppingcar_addCar:(NSString*)goodId message:(NSString*)message count:(NSInteger)count{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodId forKey:@"goodId"];
    [params setObject:message forKey:@"message"];
    [params setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [httpRequest httpPostRequest:@"app/shoppingcar/addCar.do" params:params];
}



//购物车列表
-(void)shoppingcar_carList{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/shoppingcar/carList.do" params:params];

}



//删除购物车得商品
-(void)shoppingcar_deleteCar:(NSString*)goodId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodId forKey:@"id"];
    [httpRequest httpPostRequest:@"app/shoppingcar/deleteCar.do" params:params];

}


//修改购物车-商品数量
-(void)shoppingcar_updateCar:(NSString*)goodId message:(NSString*)message count:(NSInteger)count{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:goodId forKey:@"id"];
    [params setObject:message forKey:@"message"];
    [params setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [httpRequest httpPostRequest:@"app/shoppingcar/updateCar.do" params:params];
}


//查看是否有抽奖资格
-(void)cash_scanner:(NSString*)qrcode{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:qrcode forKey:@"qrcode"];
    [httpRequest httpPostRequest:@"app/cash/scanner.do" params:params];
}

//领取抽奖
-(void)cash_exchange:(NSDictionary*)dict{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:dict[@"name"] forKey:@"name"];
    [params setObject:dict[@"money"] forKey:@"money"];
    [params setObject:dict[@"number"] forKey:@"number"];
    [httpRequest httpPostRequest:@"app/cash/exchange.do" params:params];
}

//我的电瓶首页数据
-(void)battery_getUserbatterybyUserId{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/battery/getUserbatterybyUserId.do" params:params];
}

//获取押金列表
-(void)battery_getbatteryTypeList{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/battery/getbatteryTypeList.do" params:params];
}


//支付押金
-(void)battery_addDeposit:(NSString*)deposit{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:deposit forKey:@"deposit"];
    [httpRequest httpPostRequest:@"app/battery/addDeposit.do" params:params];
}


//支付租金
-(void)battery_addRent:(NSString*)year{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:year forKey:@"year"];
    [httpRequest httpPostRequest:@"app/battery/addRent.do" params:params];
}


//获取更换记录
-(void)battery_getOldBatteryList{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/battery/getOldBatteryList.do" params:params];
}


//退押金
-(void)battery_returnDeposit{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [httpRequest httpPostRequest:@"app/battery/returnDeposit.do" params:params];
}


//更换电池扫一扫获取数据
-(void)battery_scan:(NSString*)number year:(NSString*)year{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:year forKey:@"year"];
    [params setObject:number forKey:@"number"];
    [httpRequest httpPostRequest:@"app/battery/scan.do" params:params];
}


//支付更换电池费用
-(void)battery_exchange:(NSString*)number year:(NSString*)year{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:TOKEN forKey:@"userId"];
    [params setObject:year forKey:@"year"];
    [params setObject:number forKey:@"number"];
    [httpRequest httpPostRequest:@"app/battery/exchange.do" params:params];
}
@end
