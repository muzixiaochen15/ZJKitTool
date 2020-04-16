//
//  ZJDatabaseDetailViewController.m
//  ZJKitTool
//
//  Created by qunlee on 2020/4/12.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJDatabaseDetailViewController.h"
#import "ZJCollectionViewCell.h"
#import "ZJImageModel.h"
#import "ZJDBDetailItem.h"
#import "ZJDBDetailCollectionViewCell.h"

@interface ZJDatabaseDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    ZJDatabaseDetailViewModel *viewModel;
}
@property(nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ZJDatabaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView 普通首页布局";
    
    [self.collectionView registerClass:[ZJDBDetailCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJDBDetailCollectionViewCell class])];
    
    viewModel = [[ZJDatabaseDetailViewModel alloc]init];
    kWeakObject(self)
    [viewModel setExamsWithCompletion:^{
        [weakObject.collectionView reloadData];
    }];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: collectionView];
        
        _collectionView = collectionView;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collectionView.collectionViewLayout = layout;
        
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    return _collectionView;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return viewModel.paperList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJDBDetailCollectionViewCell *cell = (ZJDBDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJDBDetailCollectionViewCell class]) forIndexPath:indexPath];
    ZJDBDetailItem *item = viewModel.paperList[indexPath.row];
    cell.titleView.titleLabel.attributedText = item.attr;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJDBDetailItem *item = viewModel.paperList[indexPath.row];
    return CGSizeMake(ScreenWidth, item.contentHeight + marginTB * 2);
}
static const CGFloat marginTB = 10;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(marginTB, 0, marginTB, 0);
}

@end
