//
//  CustomSegmentView.h
//  Meiquer
//
//  Created by Bin WU on 15/3/6.
//  Copyright (c) 2015年 Bin WU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomSegmentView;
@protocol CustonSegmentDelegate <NSObject>

@optional
- (void)clickSegmentBtn:(CustomSegmentView *)view type:(NSUInteger)btnIndex;

@end

@protocol CustonSegmentDelegate;
@interface CustomSegmentView : UIView
@property(nonatomic,assign)id<CustonSegmentDelegate>delegate;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)NSInteger selectIndex;//选中的按钮
@property(nonatomic,strong)UIColor *normalColor;//正常的颜色
@property(nonatomic,strong)UIColor *selectColor;//选中的颜色
@end

