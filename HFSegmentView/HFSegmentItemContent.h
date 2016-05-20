//
//  HFSegmentItemContent.h
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFSegmentItemContent;

@protocol HFSegmentItemContentDelegate <NSObject>

@optional
- (void)segmentItemContent:(HFSegmentItemContent *)itemContent didSelectedAtIndex:(NSInteger)index;

@end

@interface HFSegmentItemContent : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, weak) id<HFSegmentItemContentDelegate> delegate;

@end
