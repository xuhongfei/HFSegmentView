//
//  HFSegmentItem.h
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFSegmentItem;

typedef void (^SelectedItemAction)(HFSegmentItem *item);

@interface HFSegmentItem : UIView

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL highlight;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;


@property (nonatomic, copy) SelectedItemAction selectedAction;

/**
 *  间距
 */
@property (nonatomic, assign) CGFloat space;


+ (CGFloat)calcuWidth: (NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
