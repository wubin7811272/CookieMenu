//
//  MenuCell.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuCell.h"
#import "CookMenu_Header.h"
@interface MenuCell()
{
    UIView *btnView;
    
    UIView *arrowView;//箭头图片
    UIImageView *arrowImageView;
    
    NSMutableArray *btnArr;
    
    NSInteger currentIndex;//记录当前点击的按钮
}
@end
@implementation MenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10.0f)];
        arrowView.backgroundColor = COLOR_RGB(234, 234, 234);
        [self addSubview:arrowView];
        arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18.0f, 10.0f)];
        arrowImageView.image = [UIImage imageNamed:@"listarrow_grey.png"];
        [arrowView addSubview:arrowImageView];
        
        
        btnView = [[UIView alloc] initWithFrame:CGRectMake(0, arrowView.frame.size.height, SCREEN_WIDTH, 0.0f)];
        btnView.backgroundColor = COLOR_RGB(213, 213, 213);
        [self addSubview:btnView];
        
        btnArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
- (void)loadCookMenuWithArr:(NSArray *)array selectBtnIdex:(NSInteger)index
{
    CGFloat buttonWidth = (SCREEN_WIDTH - 40.0f)/3;
    CGFloat buttonHeight = 35.0f;
    CGFloat btnViewHeight = 0.0f;
    
    for (UIButton *button in btnArr) {
        [button removeFromSuperview];
        __block UIButton *myBtn = button;
        myBtn = nil;
    }
    [btnArr removeAllObjects];
    for (int i=0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10.0f+(i%3)*(buttonWidth+10.0f), 10.0f+(i/3)*(buttonHeight + 10.0f), buttonWidth, buttonHeight);
        button.backgroundColor = COLOR_RGB(234, 234, 234);
        button.layer.cornerRadius = buttonHeight/2;
        [button setTitle:[array[i] objectForKey:@"t"] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_RGB(83, 83, 83) forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14.0f);
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:button];
        [btnArr addObject:button];
        btnViewHeight = (i/3 + 1)*(buttonHeight + 10.0f)+10.0f;
    }
    arrowImageView.center = CGPointMake(index*(SCREEN_WIDTH)/3+SCREEN_WIDTH/6, arrowView.frame.size.height/2.0f+1.0f);
    
    btnView.frame = CGRectMake(0.0f, arrowView.frame.size.height, SCREEN_WIDTH, btnViewHeight);
    _cellRowHeight = btnViewHeight+arrowView.frame.size.height;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)btnClick:(UIButton *)sender
{
    currentIndex = [btnArr indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(didSelectMenuWithIndex:)]) {
        [self.delegate didSelectMenuWithIndex:currentIndex];
    }
}
@end
