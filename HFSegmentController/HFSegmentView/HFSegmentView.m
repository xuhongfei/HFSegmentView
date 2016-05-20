//
//  HFSegmentView.m
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import "HFSegmentView.h"
#import "HFSegmentItemContent.h"
#import "HFSegmentViewCell.h"

@interface HFSegmentView () <HFSegmentItemContentDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    CGFloat _titleHeight;
    NSArray<UIViewController *> *_viewControllers;
}

@property (nonatomic, strong) HFSegmentItemContent *titleView;
@property (nonatomic, strong) UICollectionViewFlowLayout *cLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HFSegmentView

- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray<UIViewController *> *)viewControllers
{
    if (self = [super initWithFrame:frame]) {
        _titleHeight = height;
        _viewControllers = viewControllers;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupAllViews];
    }
    
    return self;
}

- (void)setupAllViews
{
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    
    for (UIViewController *vc in _viewControllers) {
        [titles addObject:vc.title];
    }
    
    self.titleView = [[HFSegmentItemContent alloc] initWithFrame:CGRectZero titles:titles];
    self.titleView.delegate = self;
    [self addSubview:self.titleView];
    
    self.cLayout = [[UICollectionViewFlowLayout alloc] init];
    self.cLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_cLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[HFSegmentViewCell class] forCellWithReuseIdentifier:@"hf segment view cell"];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.collectionView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = self.collectionView.contentOffset;
        CGFloat pageFloat = offset.x / self.collectionView.bounds.size.width + 0.5;
        if (pageFloat > _viewControllers.count) {
            pageFloat = _viewControllers.count;
        }
        
        NSInteger page = (NSInteger)pageFloat;
        self.titleView.page = page;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, _titleHeight);
    self.collectionView.frame = CGRectMake(0, _titleHeight, self.frame.size.width, self.frame.size.height - _titleHeight);
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _viewControllers.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HFSegmentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hf segment view cell" forIndexPath:indexPath];
    UIViewController *vc = _viewControllers[indexPath.section];
    if (!vc.isViewLoaded) {
        [vc loadViewIfNeeded];
    }
    
    cell.view = vc.view;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - HFSegmentItemContentDelegate
- (void)segmentItemContent:(HFSegmentItemContent *)itemContent didSelectedAtIndex:(NSInteger)index
{
    CGFloat width = self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:(CGPointMake(width * index, 0)) animated:YES];
}

@end
