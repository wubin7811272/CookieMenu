//
//  CustomSegmentView.m
//  Meiquer
//
//  Created by Bin WU on 15/3/6.
//  Copyright (c) 2015年 Bin WU. All rights reserved.
//

#import "CustomSegmentView.h"

#define FONT(float) [UIFont systemFontOfSize:float]
#define COLOR_RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface CustomSegmentView()
{
    UIScrollView *rootScroll;
    //按钮数组
    NSMutableArray *buttons;
    //标记当前呗选中的按钮
    NSUInteger currentIndex;
    //标记当前被选中的按钮
    UILabel *lineLabel;
    
    CGFloat labelWidth;
}
@end
@implementation CustomSegmentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        buttons = [[NSMutableArray alloc] initWithCapacity:0];
        
        rootScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:rootScroll];
        
        lineLabel = [[UILabel alloc] init];
        [rootScroll addSubview:lineLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([buttons count]==0) {
        if (self.normalColor == nil) {
            self.normalColor = COLOR_RGB(83, 83, 83);
        }
        if (self.selectColor == nil) {
            self.selectColor = COLOR_RGB(230, 51, 62);
        }
        rootScroll.showsHorizontalScrollIndicator = NO;
        rootScroll.scrollEnabled = self.titles.count>5?YES:NO;
        
        labelWidth = self.titles.count>5?SCREEN_WIDTH/5:SCREEN_WIDTH/self.titles.count;
        rootScroll.contentSize = CGSizeMake(self.titles.count*labelWidth, self.frame.size.height);
        lineLabel.frame = CGRectMake(self.selectIndex * labelWidth, self.frame.size.height-2.0f, labelWidth, 2);
        lineLabel.backgroundColor = self.selectColor;
        
        if (self.titles.count>5) {
            if (self.selectIndex == self.titles.count-1)
            {
                [UIView animateWithDuration:0.35 animations:^{
                    rootScroll.contentOffset = CGPointMake(self.selectIndex * labelWidth-2*labelWidth<=0?0:self.selectIndex * labelWidth-4*labelWidth, 0);
                } completion:^(BOOL finished) {
                    
                }];
            }else if (self.selectIndex == self.titles.count-2)
            {
                [UIView animateWithDuration:0.35 animations:^{
                    rootScroll.contentOffset = CGPointMake(self.selectIndex * labelWidth-2*labelWidth<=0?0:self.selectIndex * labelWidth-3*labelWidth, 0);
                } completion:^(BOOL finished) {
                    
                }];
            }
            else
            {
                [UIView animateWithDuration:0.35 animations:^{
                    rootScroll.contentOffset = CGPointMake(self.selectIndex * labelWidth-2*labelWidth<=0?0:self.selectIndex * labelWidth-2*labelWidth, 0);
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        }
        

        [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [buttons addObject:button];
            button.frame = CGRectMake(idx*labelWidth, 0, labelWidth, self.frame.size.height-lineLabel.frame.size.height);
            button.titleLabel.font = FONT(14.0f);
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:self.normalColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectColor forState:UIControlStateSelected];
            if (idx == self.selectIndex) {
                button.selected = YES;
            }
            [button addTarget:self
                       action:@selector(segmentBtnPressed:)
             forControlEvents:UIControlEventTouchUpInside];
            [rootScroll addSubview:button];
        }];
    }

}
- (void)segmentBtnPressed:(UIButton *)sender
{
    for (UIButton *button in buttons) {
        button.selected = NO;
    }
    sender.selected = YES;
    currentIndex = [buttons indexOfObject:sender];
    [UIView animateWithDuration:0.5 animations:^{
        lineLabel.frame = CGRectMake(currentIndex*labelWidth, self.frame.size.height - 2.0f, labelWidth, 2.0f);
    } completion:nil];
    if (self.titles.count>5)
    {
        if (sender != [buttons lastObject]&&sender != buttons[buttons.count-2]) {
            [UIView animateWithDuration:0.35 animations:^{
                rootScroll.contentOffset = CGPointMake(currentIndex * labelWidth-2*labelWidth<=0?0:currentIndex * labelWidth-2*labelWidth, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
    if ([self.delegate respondsToSelector:@selector(clickSegmentBtn:type:)]) {
        [self.delegate clickSegmentBtn:self type:currentIndex];
    }
}
@end
