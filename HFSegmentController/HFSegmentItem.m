//
//  HFSegmentItem.m
//  HFSegmentController
//
//  Created by xuhongfei on 16/5/20.
//  Copyright © 2016年 xuhongfei. All rights reserved.
//

#import "HFSegmentItem.h"

@interface HFSegmentItem ()
{
    id _target;
    SEL _action;
    BOOL touchedFlag;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL hasHighlightColor;
@property (nonatomic, assign) BOOL hasNormalColor;

@end

#define HF_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define HF_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DEFAULT_COLOR           [UIColor grayColor]
#define DEFAULT_COLOR_HIGHLIGHT [UIColor orangeColor]
#define DEFAULT_FONT            [UIFont systemFontOfSize:14]

@implementation HFSegmentItem

+ (CGFloat)calcuWidth:(NSString *)title
{
    HFSegmentItem *item = [[HFSegmentItem alloc] initWithFrame:CGRectZero title:title];
    return [item calcuWidth] + item.space;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        self.space = 8.f;
        self.title = title;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    self.titleLabel.font = font;
    [self setNeedsLayout];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    
    self.hasHighlightColor = YES;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    
    self.hasNormalColor = YES;
}

- (void)setHighlight:(BOOL)highlight
{
    _highlight = highlight;
    
    self.titleLabel.textColor = highlight ? _hasHighlightColor ? self.highlightColor : DEFAULT_COLOR_HIGHLIGHT : _hasNormalColor ? self.normalColor : DEFAULT_COLOR;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = DEFAULT_COLOR;
        _titleLabel.font = DEFAULT_FONT;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonWidth = [self calcuWidth];
    self.frame = (CGRect){self.frame.origin, {buttonWidth + self.space, self.frame.size.height}};
    self.titleLabel.frame = CGRectMake(self.space / 2, 0, buttonWidth, self.frame.size.height);
}

#define MIN_WIDTH 32.f
#define MAX_WIDTH HF_SCREEN_WIDTH / 2.f
- (CGFloat)calcuWidth
{
    if (self.title == nil) {
        return MIN_WIDTH;
    }
    
    UIFont *font = self.font == nil ? DEFAULT_FONT : self.font;
    CGRect frame = [self.title boundingRectWithSize:CGSizeMake(MAX_WIDTH, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    CGFloat width = frame.size.width;
    return width > MIN_WIDTH ? width : MIN_WIDTH;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    
    if (touchPoint.x >= 0 && touchPoint.x <= self.bounds.size.width && touchPoint.y >= 0 && touchPoint.y <= self.bounds.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = .2f;
        }];
        touchedFlag = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    
    if (touchPoint.x >= 0 && touchPoint.x <= self.bounds.size.width && touchPoint.y >= 0 && touchPoint.y <= self.bounds.size.height) {
        if (touchedFlag) {
            if (self.selectedAction) {
                self.selectedAction(self);
            }
        }
        
    }
    touchedFlag = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
        
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
