//
//  ZJDBDetailCollectionViewCell.m
//  ZJKitTool
//
//  Created by qunlee on 2020/4/12.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJDBDetailCollectionViewCell.h"

@interface ZJDBDetailCollectionViewCell ()

@end

@implementation ZJDBDetailCollectionViewCell
static const CGFloat edge = 20;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         _titleView = [ZJDatabaseDetailTitleView new];
        [self addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(edge);
            make.right.mas_equalTo(self).mas_offset(-edge);
            make.top.mas_equalTo(self).mas_offset(10);
            make.bottom.mas_equalTo(self).mas_offset(-10);
        }];
    }
    return self;
}

- (void)setUpAllView{
  
}

@end
