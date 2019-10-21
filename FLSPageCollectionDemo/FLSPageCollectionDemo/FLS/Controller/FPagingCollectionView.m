//
//  FPagingCollectionView.m
//  FLSPageCollectionDemo
//
//  Created by fls on 2019/7/25.
//  Copyright © 2019年 天立泰. All rights reserved.
//

#import "FPagingCollectionView.h"
#import "FLSItemListPortraitView.h"
#import "MAPageControl.h"
#import "FLSModel.h"
#import "FLSHeader.h"

@interface FPagingCollectionView()

@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSMutableArray * dataListArray;
//竖屏礼物
@property (nonatomic, strong) FLSItemListPortraitView *itemListPortraitView;
//分页
@property (nonatomic, strong) MAPageControl *pageControl;
//当前选中的礼物
@property (nonatomic, strong) FLSItemItemModel *currentSelectedItemModel;
//当前选中的礼物分类索引
@property (nonatomic, assign) NSInteger currentSelectedGroupIndex;



@end


@implementation FPagingCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = [UIColor redColor];
    NSLog(@"%@",self.dataListArray);
    [self addSubview:self.itemListPortraitView];
    [self addSubview:self.pageControl];
    [self setDataListModel];
}


- (FLSItemListPortraitView *)itemListPortraitView
{
    if (!_itemListPortraitView) {
        _itemListPortraitView = [[FLSItemListPortraitView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
        _itemListPortraitView.aimView = self;//🌺背景界面
        _itemListPortraitView.backgroundColor =[UIColor orangeColor];
        WEAKSELF
        _itemListPortraitView.portraitPageBlock = ^(NSInteger currentGroupIndex, NSInteger currentGroupPageCount, NSInteger pageIndexInCurrentGroup) {
            [weakSelf.pageControl setNumberOfPages:currentGroupPageCount];
            [weakSelf.pageControl setCurrentPage:pageIndexInCurrentGroup];
        };
        _itemListPortraitView.portraitActionBlock = ^(PortraitActionType actionType, NSInteger selectIndexRow, FLSItemItemModel *itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto) {
            
            switch (actionType) {
                case PortraitActionTypeDrag:
                case PortraitActionTypeSelectMock:
                {
                    //隐藏sendView
                }
                    break;
                case PortraitActionTypeSelectItem:
                {
                    //选中某个item
                    if (!itemModel) {
                        return ;
                    }
                    weakSelf.currentSelectedItemModel = itemModel;
                }
                    break;
                case PortraitActionTypeScrollToPage:
                {
                    weakSelf.currentSelectedGroupIndex = selectIndexRow;
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _itemListPortraitView;
}

- (void)setDataListModel{
    if (!self.dataListArray) {
        return;
    }
    if (self.dataListArray.count <= 0) {
        return;
    }
    self.itemListPortraitView.listsData = self.dataListArray;
}
- (MAPageControl *)pageControl{
    if (!_pageControl) {
        //分页
        _pageControl = [[MAPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height -5, APP_W, 5)];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.normalImage = [UIImage imageNamed:@"pageControl_normal"];
        _pageControl.selectedImage = [UIImage imageNamed:@"pageControl_selected"];
    }
    return _pageControl;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =@[@{
                          @"itemTypeId": @"1",
                          @"itemTypeName": @"分类1",
                          @"itemList":@[
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      },
                                  @{
                                      @"contClick": @"1",
                                      @"itemInfoId": @"11",
                                      @"itemName": @"测试",
                                      @"itemPlayType": @"0",
                                      @"itemPrice": @"1",
                                      @"itemTypeId": @"1",
                                      @"imageName": @"test5"
                                      }
                                  ]
                          }];
    }
    return _dataArray;
}
- (NSMutableArray *)dataListArray{
    if (!_dataListArray) {
        _dataListArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < self.dataArray.count ; i ++) {
            NSDictionary * listDic = self.dataArray[i];
            FLSModel * listModel = [[FLSModel alloc] init];
            listModel.itemTypeId = listDic[@"itemTypeId"];
            listModel.itemTypeName = listDic[@"itemTypeName"];
            NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
            NSArray * itemData = listDic[@"itemList"];
            for (int j = 0; j < itemData.count; j ++) {
                NSDictionary * itemDic = itemData[j];
                FLSItemItemModel * itemModel = [[FLSItemItemModel alloc] init];
                itemModel.itemImageUrl = itemDic[@"itemName"];
                itemModel.itemInfoId = itemDic[@"itemName"];
                itemModel.itemName = itemDic[@"itemName"];
                itemModel.itemPlayType = itemDic[@"itemName"];
                itemModel.itemPrice = itemDic[@"itemName"];
                itemModel.itemTypeId = itemDic[@"itemName"];
                itemModel.imageName = itemDic[@"itemName"];
                itemModel.contClick = NO;
                itemModel.isMock = NO;
                [itemArray addObject:itemModel];
            }
            listModel.itemList = itemArray;
            [_dataListArray addObject:listModel];
        }
    }
    return _dataListArray;
}

@end
