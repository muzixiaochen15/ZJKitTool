//
//  ZJPopShowView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/11/29.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopShowView.h"

@interface ZJPopShowView (){
    NSInteger selIndex;
}
@end

@implementation ZJPopShowView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        kWeakObject(self)
        [UILabel zj_labelWithFont:kFontSize(14) lines:1 text:@"ZJPopShowView" textColor:kLightGrayColor superView:self constraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
                
        UIButton *OKBtn = [UIButton zj_buttonWithTitle:@"确认" superView:self constraints:^(MASConstraintMaker *make) {
        } touchUp:^(id sender) {
            if (weakObject.okBlock) {
                weakObject.okBlock(selIndex);
            }
        }];
        
        OKBtn.backgroundColor = kLightGrayColor;
        OKBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [OKBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        OKBtn.layer.cornerRadius = 20;
        
        UIButton *cancelBtn = [UIButton zj_buttonWithTitle:@"取消" superView:self constraints:^(MASConstraintMaker *make) {
        } touchUp:^(id sender) {
            if (weakObject.cancelBlock) {
                weakObject.cancelBlock();
            }
        }];
        
        cancelBtn.backgroundColor = kLightGrayColor;
        cancelBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [cancelBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        cancelBtn.layer.cornerRadius = 20;
        
        [@[OKBtn, cancelBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
        [@[OKBtn, cancelBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.mas_equalTo(-10);

        }];
    }
    return self;
}

@end
