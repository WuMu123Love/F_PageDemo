//
//  FLSItemListPortraitView.h
//  FLSPageCollectionDemo
//
//  Created by 天立泰 on 2018/10/23.
//  Copyright © 2018年 天立泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLSModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PortraitActionType) {
    PortraitActionTypeDrag = 1, //滑动
    PortraitActionTypeSelectMock, //点击假数据
    PortraitActionTypeSelectItem, //选中某个item
    PortraitActionTypeScrollToPage, //滑动到某页
};

/**
 竖屏礼物回调
 
 @param currentGroupIndex 当前组索引
 @param currentGroupPageCount 当前组页面数
 @param pageIndexInCurrentGroup 当前页面在当前组的位置
 */
typedef void(^PortraitPageBlock)(NSInteger currentGroupIndex, NSInteger currentGroupPageCount,NSInteger pageIndexInCurrentGroup);

/**
 竖屏礼物动作回调
 
 @param actionType 动作类型
 @param selectIndexRow 动作触发结果
 */
typedef void(^PortraitActionBlock)(PortraitActionType actionType, NSInteger selectIndexRow,  FLSItemItemModel *__nullable itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto);

//竖屏礼物列表
@interface FLSItemListPortraitView : UIView

@property (nonatomic, weak) UIView *aimView;
@property (nonatomic, strong) NSArray *listsData;
@property (nonatomic, strong) PortraitPageBlock portraitPageBlock;
@property (nonatomic, strong) PortraitActionBlock portraitActionBlock;

/**
 选中某一组
 
 @param groupIndex 组索引
 */
- (void)selectGroup:(NSInteger)groupIndex withAnimated:(BOOL)animated;

/**
 根据itemModel，找到当前cell相对于bgView的位置
 
 @param itemModel 目标item
 @param block 回参
 */
- (void)locatedItem:(FLSItemItemModel *)itemModel positionBlock:(void(^)(CGRect frame,CGPoint point))block;

@end

NS_ASSUME_NONNULL_END
