//
//  FLSModel.h
//  FLSPageCollectionDemo
//
//  Created by 天立泰 on 2018/10/23.
//  Copyright © 2018年 天立泰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLSItemItemModel : NSObject

@property (nonatomic, copy) NSString *itemImageUrl;
@property (nonatomic, copy) NSString *itemInfoId;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemPlayType;
@property (nonatomic, copy) NSString *itemPrice;
@property (nonatomic, copy) NSString *itemThumbUrl;
@property (nonatomic, copy) NSString *itemTypeId;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) BOOL contClick;//是否能连击
@property (nonatomic, assign) BOOL isMock;//本地字段,是否是凑数据
@end

@interface FLSModel : NSObject
@property (nonatomic, strong) NSArray  *itemList; //FLSItemItemModel
@property (nonatomic, copy) NSString * itemTypeId;
@property (nonatomic, copy) NSString *itemTypeName;
@end

NS_ASSUME_NONNULL_END
