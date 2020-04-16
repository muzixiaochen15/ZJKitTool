//
//  ZJDatabaseDetailTitleView.m
//  ZJKitTool
//
//  Created by qunlee on 2020/4/12.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJDatabaseDetailTitleView.h"
#import "UIColor+ZJColor.h"
#import <YYText.h>
@interface ZJDatabaseDetailTitleView ()
@end

@implementation ZJDatabaseDetailTitleView

static const CGFloat marginLeft = 20.0;
static const CGFloat marginTop = 0;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor zj_colorWithHex:0xf5f5f5];
        
        self.titleLabel = [UILabel zj_labelWithFontSize:15 lines:0 text:@"-." textColor:kBlackColor superView:self constraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.top.mas_equalTo(marginTop);
                make.bottom.mas_equalTo(-marginTop);
                make.right.mas_equalTo(-marginLeft);
             }];
        self.titleLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}



@end
