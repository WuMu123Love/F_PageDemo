//
//  FLSCell.m
//  FLSPageCollectionDemo
//
//  Created by 天立泰 on 2018/10/24.
//  Copyright © 2018年 天立泰. All rights reserved.
//

#import "FLSCell.h"


@interface FLSCell()
@property (weak, nonatomic) IBOutlet UILabel *conTitle;

@end

@implementation FLSCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"FLSCell" owner:self options:nil].firstObject;
    }
    return self;
}
- (void)setItemModel:(FLSItemItemModel *)itemModel{
    _itemModel = itemModel;
    self.conTitle.text = itemModel.itemName;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
