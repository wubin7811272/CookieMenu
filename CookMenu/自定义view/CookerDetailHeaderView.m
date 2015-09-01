//
//  CookerDetailHeaderView.m
//  CookMenu
//
//  Created by mac on 15/5/4.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "CookerDetailHeaderView.h"
#import "CookMenu_Header.h"
@interface CookerDetailHeaderView()

@end
@implementation CookerDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, 40)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.3;
        [self addSubview:backView];
        _dishNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, 40)];
        _dishNameLable.textColor = UIColorFromRGB(0xF0F0F0);
        _dishNameLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dishNameLable];
        
    }
    return self;
}
- (void)loadUIWithDictionary:(NSDictionary *)liaosDict
{
    
    NSArray *list = liaosDict[@"list"];
    NSArray *list_t = liaosDict[@"list_t"];
    NSArray *list_f = liaosDict[@"list_f"];
    
    UILabel *yongliaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, SCREEN_WIDTH, 20.0f)];
    yongliaoLabel.textColor = UIColorFromRGB(0x73471c);
    yongliaoLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    yongliaoLabel.text = @"用料";
    [self addSubview:yongliaoLabel];
    CGFloat yongliaoViewHeight = 0.0f;
    for (int i=0; i<list.count; i++) {
        NSDictionary *yongliaoDict = list[i];
        UIView *view = [self creatyongliaoViewWithDict:yongliaoDict frame:CGRectMake(10.0f, yongliaoLabel.frame.size.height+yongliaoLabel.frame.origin.y+10+i*55.0f, SCREEN_WIDTH-10.0f, 45.0f)];
        [self addSubview:view];
        yongliaoViewHeight = yongliaoLabel.frame.size.height+yongliaoLabel.frame.origin.y+10+(i+1)*55.0f;
    }
    
    
    UILabel *fuliaoLabel = [[UILabel alloc] init];
    fuliaoLabel.frame = list_f.count>0?CGRectMake(10.0f, yongliaoViewHeight, SCREEN_WIDTH, 20.0f):CGRectMake(10.0f,  yongliaoViewHeight-10.0f, 0, 0);
    fuliaoLabel.textColor = UIColorFromRGB(0x73471c);
    fuliaoLabel.font = FONT(17.0f);
    fuliaoLabel.text = list_f.count>0?@"辅料":@"";
    [self addSubview:fuliaoLabel];
    
    CGFloat fuliaoViewHeight = 0.0f;
    UIView *fuliaoView = [self creatFuliaoTiaoliaoViewWithArray:list_f];
    if (fuliaoView == nil) {
        fuliaoViewHeight = yongliaoViewHeight;
    }else
    {
        
        fuliaoView.frame = CGRectMake(10.0f, fuliaoLabel.frame.origin.y+fuliaoLabel.frame.size.height, fuliaoView.frame.size.width, fuliaoView.frame.size.height);
        [self addSubview:fuliaoView];
        fuliaoViewHeight = fuliaoView.frame.size.height+fuliaoView.frame.origin.y;
    }
    
    UILabel *tiaoliaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, fuliaoViewHeight, SCREEN_WIDTH, 20.0f)];
    tiaoliaoLabel.textColor = UIColorFromRGB(0x73471c);
    tiaoliaoLabel.font = FONT(17.0f);
    tiaoliaoLabel.text = @"调料";
    [self addSubview:tiaoliaoLabel];
    
    CGFloat tiaoliaoViewHeight = 0.0f;
    UIView *tiaolaioView = [self creatFuliaoTiaoliaoViewWithArray:list_t];
    if (tiaolaioView == nil) {
        tiaoliaoViewHeight = fuliaoViewHeight;
    }else
    {
        
        tiaolaioView.frame = CGRectMake(10.0f, tiaoliaoLabel.frame.origin.y+tiaoliaoLabel.frame.size.height, tiaolaioView.frame.size.width, tiaolaioView.frame.size.height);
        [self addSubview:tiaolaioView];
        tiaoliaoViewHeight = tiaolaioView.frame.size.height+tiaolaioView.frame.origin.y;
    }
    
    UILabel *buzhouLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, tiaoliaoViewHeight+10.0f, SCREEN_WIDTH, 20.0f)];
    buzhouLabel.textColor = UIColorFromRGB(0x73471c);
    buzhouLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    buzhouLabel.text = @"步骤";
    [self addSubview:buzhouLabel];
    
    self.headerViewHeight = buzhouLabel.frame.origin.y+buzhouLabel.frame.size.height+10.0f;
}

- (UIView *)creatyongliaoViewWithDict:(NSDictionary *)dict frame:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 45.0f)];
    imageView.layer.cornerRadius = 2.0f;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"icon"]] placeholderImage:[UIImage imageNamed:@"imageBackground.png"]];
    [view addSubview:imageView];
    
    CGFloat labelHeight = view.frame.size.height/2.0f;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10.0f, 0.0f, 200.0f, labelHeight)];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    titleLabel.font = FONT(17.0f);
    titleLabel.text = dict[@"title"];
    [view addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10.0f, labelHeight, 200.0f, labelHeight)];
    detailLabel.textColor = UIColorFromRGB(0x666666);
    detailLabel.font = FONT(17.0f);
    detailLabel.text = dict[@"num"];
    [view addSubview:detailLabel];
    return view;
}
- (UIView *)creatFuliaoTiaoliaoViewWithArray:(NSArray *)array
{
    if (array.count >0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0F, SCREEN_WIDTH-10.0f, 0.0f)];
        CGFloat labelWidth = view.frame.size.width/2.0f;
        CGFloat viewHeight = 0.0f;
        for (int i=0; i<array.count; i++) {
            
            NSDictionary *dict = array[i];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i%2)*labelWidth, 10.0f+(i/2)*30.0f, labelWidth, 20.0f)];
            label.font = FONT(15.0f);
            label.textColor = UIColorFromRGB(0x666666);
            label.text = [NSString stringWithFormat:@"%@:%@",dict[@"title"],dict[@"unit"]];
            [view addSubview:label];
            
            viewHeight = 10.0f+(i/2)*30.0f+30.0f;
        }
        view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH-10.0f, viewHeight);
        return view;
    }else
    {
        
        return nil;
    }
    
}

@end
