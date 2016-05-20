//
//  HFSegmentViewCell.m
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import "HFSegmentViewCell.h"

@implementation HFSegmentViewCell

- (void)setView:(UIView *)view
{
    if (_view) {
        [_view removeFromSuperview];
    }
    
    [self.contentView addSubview:view];
    [self setNeedsLayout];
    
    _view = view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.view.frame = self.contentView.bounds;
}

@end
