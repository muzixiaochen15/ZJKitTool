//
//  ZJPopShowView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/11/29.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJBasePopupView.h"

NS_ASSUME_NONNULL_BEGIN

// 选项
typedef void(^OKBtnBlock)(NSInteger optionIndex);
typedef void(^CancelBtnBlock)(void);

@interface ZJPopShowView : ZJBasePopupView


@property (nonatomic, copy) OKBtnBlock okBlock;
@property (nonatomic, copy) CancelBtnBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
