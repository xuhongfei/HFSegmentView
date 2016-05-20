//
//  HFSegmentItemContent.m
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import "HFSegmentItemContent.h"
#import "HFSegmentItem.h"

@interface HFSegmentItemContent ()
{
    CGFloat _buttonWidthSum;
    HFSegmentItem *_currentItem;
}

@property (nonatomic, strong) UIView *buttonContentView;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSMutableArray *buttonWidths;

@property (nonatomic, strong) NSArray *items;

@end

@implementation HFSegmentItemContent


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        
        self.items = [titles copy];
        [self setupAllButtons];
    }
    
    return self;
}

- (void)setupAllButtons
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.buttonContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.buttonContentView];
    
    self.line = [[UIView alloc] initWithFrame:CGRectZero];
    self.line.backgroundColor = [UIColor orangeColor];
    [self addSubview: self.line];
    
    for (NSString *title in self.items) {
        HFSegmentItem *item = [[HFSegmentItem alloc] initWithFrame:CGRectZero title:title];
        
        __weak __typeof(self) weakSelf = self;
        item.selectedAction = ^(HFSegmentItem *segmentItem) {
            [weakSelf buttonAction:segmentItem];
        };
        
        [self.buttonsArray addObject:item];
        [self.buttonContentView addSubview:item];
        
        CGFloat width = [HFSegmentItem calcuWidth:title];
        [self.buttonWidths addObject:@(width)];
        
        _buttonWidthSum += width;
        
        if (_currentItem == nil) {
            _currentItem = item;
            _currentItem.highlight = YES;
        }
    }
}

- (void)buttonAction:(HFSegmentItem *)item
{
    NSInteger index = [self.buttonsArray indexOfObject:item];
    
    [self setPage:index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentItemContent:didSelectedAtIndex:)]) {
        [self.delegate segmentItemContent:self didSelectedAtIndex:index];
    }
}

#pragma mark -

- (void)setPage:(NSInteger)page
{
    if (_page == page) {
        return;
    }
    
    _page = page;
    
    [self moveToPage: page];
}

- (void)moveToPage:(NSInteger) page
{
    if (page > self.buttonsArray.count) {
        return;
    }
    
    HFSegmentItem *item = self.buttonsArray[page];
    _currentItem.highlight = NO;
    _currentItem = item;
    item.highlight = YES;
    [UIView animateWithDuration:.2f animations:^{
        CGRect buttonFrame = item.frame;
        CGRect lineFrame = self.line.frame;
        lineFrame.origin.x = buttonFrame.origin.x;
        lineFrame.size.width = buttonFrame.size.width;
        self.line.frame = lineFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    
    return _buttonsArray;
}

- (NSMutableArray *)buttonWidths
{
    if (!_buttonWidths) {
        _buttonWidths = [NSMutableArray array];
    }
    
    return _buttonWidths;
}

#pragma mark - Override
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.buttonContentView.frame = CGRectMake(0, 0, width, height - 2);
    
    CGFloat space = 0;
    if (_buttonWidthSum >= width) {
        space = 0;
    } else {
        space = (width - _buttonWidthSum) / (_buttonWidths.count + 1);
    }
    
    for (int i = 0; i < self.buttonsArray.count; i ++) {
        HFSegmentItem *item = self.buttonsArray[i];
        CGFloat buttonWidth = [self.buttonWidths[i] doubleValue];
        
        if (i == 0) {
            item.frame = CGRectMake(space, 0, buttonWidth, self.buttonContentView.bounds.size.height);
        } else {
            HFSegmentItem *lastItem = self.buttonsArray[i - 1];
            item.frame = CGRectMake(space + CGRectGetMaxX(lastItem.frame), 0, buttonWidth, self.buttonContentView.bounds.size.height);
        }
    }
    
    self.line.frame = CGRectMake(_currentItem.frame.origin.x, self.buttonContentView.bounds.size.height, _currentItem.bounds.size.width, 2);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
