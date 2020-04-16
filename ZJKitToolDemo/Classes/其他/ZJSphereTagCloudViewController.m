//
//  ZJSphereTagCloudViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/2/1.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJSphereTagCloudViewController.h"
#import "DBSphereView.h"
#import "ZJPopShowView.h"

@interface ZJSphereTagCloudViewController ()<ZJPopupViewDelegate>

// 网点
@property(nonatomic ,strong) DBSphereView *sphereView;

// 弹框
@property (nonatomic, strong) ZJPopShowView *showView;

@property (nonatomic, strong) ZJPopupView *popupView;


@end

@implementation ZJSphereTagCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"球形TagView";
    self.view.backgroundColor = kLightGrayColor;
    [self setUpAllView];
    [self loadData];
}


-(void)loadData{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<500; i++) {
//        UIButton *btn = [UIButton zj_buttonWithFrame:CGRectMake(0, 0, 60, 20) title:[NSString stringWithFormat:@"%d",i] titleColor:kBlackColor imageName:nil backColor:nil fontSize:12 cornerRadius:0 traget:self action:@selector(btnAction:)];
//        [dataArray addObject:btn];
//        [self.sphereView addSubview:btn];
        
        UILabel *label = [UILabel zj_labelWithFrame:CGRectMake(0, 0, 60, 20) text:[NSString stringWithFormat:@"%d",i] fontSize:12 isBold:NO textColor:kBlackColor textAligment:NSTextAlignmentCenter numLines:1];
        [dataArray addObject:label];
        [self.sphereView addSubview:label];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
        [label addGestureRecognizer:tapGes];
    }
    [self.sphereView setCloudTags:dataArray];
}

-(void)btnAction:(UITapGestureRecognizer *)ges{
    [self.sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        ges.view.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [self showViewWithStyle:ZJPopupAnimationAlpha withTapView:ges.view];
    }];
}

-(void)showViewWithStyle:(ZJPopupAnimationStyle)style withTapView:(UIView *)tapView{
    CGFloat ratio = 1.5;
    CGFloat width = ScreenWidth * 3/4.0;
    CGFloat height = width * ratio;
    
    self.showView = [[ZJPopShowView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _showView.layer.cornerRadius = 10;
    _showView.layer.masksToBounds = YES;
    
    self.popupView = [[ZJPopupView alloc]initWithShowView:_showView
                                                superView:self.view
                                                       viewSize:CGSizeMake(width, height)
                                                       delegate:self
                                                   durationTime:0.25
                                                        bgAlpha:0.5
                                                isBGClickAction:YES
                                                   isBlurEffect:YES
                                                     animaStyle:style
                                                       closeBtn:nil];
    [self.popupView zj_showPopupView];
    
    kWeakObject(self)
    self.showView.okBlock = ^(NSInteger optionIndex) {
        [weakObject closeBtnActionWithTapView:tapView];
    };
    self.showView.cancelBlock = ^{
        [weakObject closeBtnActionWithTapView:tapView];
    };
}

- (void)closeBtnActionWithTapView:(UIView *)tapView{
    [UIView animateWithDuration:0.3 animations:^{
        tapView.transform = CGAffineTransformMakeScale(1., 1.);
    } completion:^(BOOL finished) {
        [self.sphereView timerStart];
    }];
    [self.popupView zj_hiddenPopupView];
}

-(void)zj_willShowPopupView{
    NSLog(@"将要显示 popView");
}
-(void)zj_didHiddenPopupView{
    NSLog(@"已经隐藏 popView");
}
-(void)zj_clickShowViewAction{
    NSLog(@"点击了 showView");
}

-(void)zj_clickBgViewAction{
    NSLog(@"点击了 bgView");
}

static CGFloat const edge = 20;
-(void)setUpAllView{
    [self.view addSubview:self.sphereView];
    [self.sphereView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.height.mas_equalTo(kScreenWidth > kScreenHeight?kScreenHeight - edge * 2:kScreenWidth - edge * 2);
        make.width.mas_equalTo(kScreenWidth > kScreenHeight?kScreenHeight - edge * 2:kScreenWidth - edge *2);
    }];
}

-(DBSphereView *)sphereView{
    if (!_sphereView) {
        _sphereView = [[DBSphereView alloc]init];
        _sphereView.backgroundColor = kLightGrayColor;
    }
    return _sphereView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
