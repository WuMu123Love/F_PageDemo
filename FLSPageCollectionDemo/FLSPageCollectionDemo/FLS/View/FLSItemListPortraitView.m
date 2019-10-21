//
//  FLSItemListPortraitView.m
//  FLSPageCollectionDemo
//
//  Created by 天立泰 on 2018/10/23.
//  Copyright © 2018年 天立泰. All rights reserved.
//

#import "FLSItemListPortraitView.h"
#import "MAHorizontalPageFlowlayout.h"
#import "FLSCell.h"
#import "FLSModel.h"
#import "FLSHeader.h"
#import "UIView+Extension.h"

static NSString *const ItemCollectionCellIdentifier = @"ItemCollectionCellIdentifier";
static const NSInteger kItemCountPerRow = 4; //每行显示5个
static const NSInteger kRowCount = 2; //每页显示行数

@interface FLSItemListPortraitView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *portraitCollectionView;
@property (nonatomic, strong) NSArray<NSNumber *> *groupPageIndexs;//每一页的索引
@property (nonatomic, strong) NSArray<NSNumber *> *groupPageCounts;//每一页页数
@property (nonatomic, assign) NSInteger groupTotalPageCount; //总页数
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray <FLSItemItemModel *>*totalItemList;

@end
@implementation FLSItemListPortraitView
@synthesize listsData = _listsData;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
}

- (void)initSubViews
{
    MAHorizontalPageFlowlayout *normalFlowLayout = [[MAHorizontalPageFlowlayout alloc] initWithRowCount:kRowCount itemCountPerRow:kItemCountPerRow];
    [normalFlowLayout setColumnSpacing:0 rowSpacing:0 edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    normalFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _portraitCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width_t, self.height_t) collectionViewLayout:normalFlowLayout];
    _portraitCollectionView.pagingEnabled = YES;//滚动到特定的距离
    _portraitCollectionView.dataSource = self;
    _portraitCollectionView.delegate = self;
    _portraitCollectionView.bounces = YES;//控制是否滚动视图能否超出内容边缘再弹回
    _portraitCollectionView.alwaysBounceHorizontal = YES;
    _portraitCollectionView.alwaysBounceVertical = NO;
    _portraitCollectionView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    _portraitCollectionView.showsHorizontalScrollIndicator = NO;
    _portraitCollectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_portraitCollectionView];
    [_portraitCollectionView registerClass:[FLSCell class] forCellWithReuseIdentifier:ItemCollectionCellIdentifier];
    [self layoutIfNeeded];
}

- (void)setListsData:(NSArray *)listsData
{
    if (!listsData || listsData == _listsData) {
        return;
    }
    _listsData = listsData;
    
    [self initSubViews];
    
    [self calculateListInfo];
    [self reDefineData];
    [self reloadData];
}

- (NSArray *)listsData
{
    return _listsData;
}

- (void)calculateListInfo
{
    //获取各组起始页下标数组
    NSMutableArray *indexs = [NSMutableArray new];
    NSUInteger index = 0;
    for (FLSModel *listModel in _listsData) {
        [indexs addObject:@(index)];
        NSUInteger integerCount = ceil(listModel.itemList.count / (kItemCountPerRow * kRowCount));//求大于本身的最小整数
        NSUInteger remainder = listModel.itemList.count % (kItemCountPerRow * kRowCount);
        
        if (remainder > 0) {
            integerCount += 1;
        }
        if (integerCount == 0) integerCount = 1;
        index += integerCount;
    }
    _groupPageIndexs = indexs;
    
    //总页数
    NSMutableArray *pageCounts = [NSMutableArray new];
    _groupTotalPageCount = 0;
    for (FLSModel *listModel in _listsData) {
        NSUInteger pageCount = ceil(listModel.itemList.count / (kItemCountPerRow * kRowCount));
        NSUInteger remainder = listModel.itemList.count % (kItemCountPerRow * kRowCount);
        
        if (remainder > 0) {
            pageCount += 1;
        }
        
        if (pageCount == 0) pageCount = 1;
        [pageCounts addObject:@(pageCount)];
        _groupTotalPageCount += pageCount;
    }
    _groupPageCounts = pageCounts;
    
    if (self.portraitPageBlock) {
        self.portraitPageBlock(0, [_groupPageCounts[0] integerValue], 0);
    }
}
- (void)reDefineData
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (FLSModel *listModel in _listsData) {
        
        // 理论上每页展示的item数目
        NSInteger itemCount = kItemCountPerRow * kRowCount;
        // 余数（用于确定最后一页展示的item个数）
        NSInteger remainder = listModel.itemList.count % itemCount;
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:listModel.itemList];
        
        if (remainder > 0 && remainder < itemCount) {
            //如果不够一页，就加人假数据，凑成一页
            for (NSInteger i = 0; i < itemCount - remainder; i++) {
                FLSItemItemModel *itemModel = [[FLSItemItemModel alloc] init];
                itemModel.isMock = YES;
                [arr addObject:itemModel];
            }
        }
        [tempArray addObjectsFromArray:arr];
    }
    self.totalItemList = tempArray;
}

- (void)reloadData
{
    [self.portraitCollectionView.collectionViewLayout invalidateLayout];
    [self.portraitCollectionView reloadData];
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalItemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLSCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCollectionCellIdentifier forIndexPath:indexPath];
    cell.itemModel = self.totalItemList[indexPath.row];
    return cell;

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLSItemItemModel *selectItem = self.totalItemList[indexPath.row];
    
    if (selectItem.isMock) {
        if (self.portraitActionBlock) {
            self.portraitActionBlock(PortraitActionTypeSelectMock, 0, nil, CGRectZero , CGPointZero, NO);
        }
        return;
    }
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    CGRect cellRect = [collectionView convertRect:cell.frame toView:self.aimView];
    CGPoint cellPoint = [collectionView convertPoint:cell.center toView:self.aimView];
    
    if (self.portraitActionBlock) {
        self.portraitActionBlock(PortraitActionTypeSelectItem, indexPath.row, selectItem, cellRect, cellPoint, NO);
    }
}

#pragma mark - ScrollView Actions
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.portraitActionBlock) {
        self.portraitActionBlock(PortraitActionTypeDrag, 0, nil, CGRectZero , CGPointZero, NO);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = floor((scrollView.contentOffset.x - scrollView.width_t / 2) / scrollView.width_t) + 1; //round(scrollView.contentOffset.x / scrollView.width_t);
    if (page < 0) {
        page = 0;
    }
    else if (page >= _groupTotalPageCount) {
        page = _groupTotalPageCount - 1;
    }
    
    NSInteger curGroupIndex = 0, curGroupPageIndex = 0, curGroupPageCount = 0;
    for (NSInteger i = _groupPageIndexs.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _groupPageIndexs[i];
        if (page >= pageIndex.unsignedIntegerValue) {
            curGroupIndex = i;
            curGroupPageIndex = page - ((NSNumber *)_groupPageIndexs[i]).integerValue;
            curGroupPageCount = ((NSNumber *)_groupPageCounts[i]).integerValue;
            break;
        }
    }
    
    if (self.portraitPageBlock) {
        self.portraitPageBlock(curGroupIndex, curGroupPageCount, curGroupPageIndex);
    }
    if (self.portraitActionBlock) {
        self.portraitActionBlock(PortraitActionTypeScrollToPage, curGroupIndex, nil, CGRectZero , CGPointZero, NO);
    }
    [self layoutIfNeeded];
}

- (void)selectGroup:(NSInteger)groupIndex withAnimated:(BOOL)animated
{
    if(!_listsData) {
        return;
    }
    NSInteger index = [_groupPageIndexs[groupIndex] integerValue];
    
    [self.portraitCollectionView setContentOffset:CGPointMake(self.portraitCollectionView.width_t * index, 0) animated:animated];
    
    if (self.portraitPageBlock) {
        self.portraitPageBlock(groupIndex, ((NSNumber *)_groupPageCounts[groupIndex]).integerValue, 0);
    }
    if (self.portraitActionBlock) {
        self.portraitActionBlock(PortraitActionTypeScrollToPage, groupIndex, nil, CGRectZero, CGPointZero, YES);
    }
}

- (void)locatedItem:(FLSItemItemModel *)itemModel positionBlock:(void (^)(CGRect, CGPoint))block
{
    if (!itemModel) {
        return;
    }
    NSInteger itemIndex = 0;
    for (NSInteger i = 0; i < self.totalItemList.count; i++) {
        FLSItemItemModel *item = self.totalItemList[i];
        if (itemModel.itemInfoId == item.itemInfoId) {
            itemIndex = i;
            break;
        }
    }
    
    NSInteger pageIndex = itemIndex / (kRowCount*kItemCountPerRow);
    
    [self.portraitCollectionView setContentOffset:CGPointMake(self.portraitCollectionView.width_t * pageIndex, 0) animated:NO];
    [self layoutIfNeeded];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    UICollectionViewCell *selectedCell = [self.portraitCollectionView cellForItemAtIndexPath:indexPath];
    
    CGRect cellRect = [self.portraitCollectionView convertRect:selectedCell.frame toView:self.aimView];
    CGPoint cellPoint = [self.portraitCollectionView convertPoint:selectedCell.center toView:self.aimView];
    
    if (block) {
        block(cellRect,cellPoint);
    }
    
}

@end
