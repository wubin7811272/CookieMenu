//
//  WBExpandHeader.m
//  CookMenu
//
//  Created by mac on 15/5/4.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "WBExpandHeader.h"
#define WBxpandContentOffset @"contentOffset"

@implementation WBExpandHeader{
    UIScrollView     *__scrollView;
    UIView           *__expandView;
    CGFloat          __expandHeight;
}
- (void)dealloc{
    if (__scrollView) {
        [__scrollView removeObserver:self forKeyPath:WBxpandContentOffset];
        __scrollView = nil;
    }
    __expandView = nil;
}

+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    WBExpandHeader *expandHeader = [WBExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    __expandHeight = CGRectGetHeight(expandView.frame);
    
    __scrollView = scrollView;
    __scrollView.contentInset = UIEdgeInsetsMake(__expandHeight, 0, 0, 0);
    [__scrollView insertSubview:expandView atIndex:0];
    [__scrollView addObserver:self forKeyPath:WBxpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [__scrollView setContentOffset:CGPointMake(0, -CGRectGetHeight(expandView.frame))];
    
    __expandView = expandView;
    
    __expandView.contentMode= UIViewContentModeScaleAspectFill;
    __expandView.clipsToBounds = YES;
    
    [self reSizeView];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:WBxpandContentOffset]) {
        return;
    }
    [self scrollViewDidScroll:__scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < __expandHeight * -1) {
        CGRect currentFrame = __expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        __expandView.frame = currentFrame;
    }
}

- (void)reSizeView{
    [__expandView setFrame:CGRectMake(0, -1*__expandHeight, CGRectGetWidth(__expandView.frame), __expandHeight)];
}

@end
