//
//  MenuDetailViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "WBExpandHeader.h"
#import "CookMenu_Header.h"
#import "MenuDetailCell.h"
#import "CookerDetailHeaderView.h"

@interface MenuDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _detailTabelRowHeight;
    CookerDetailHeaderView *_headerView;
    
}
@property(nonatomic,strong)NSMutableArray *favoriteArr;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UITableView *detailTable;
@property(nonatomic,strong)UIView *favoriteView;
@end

@implementation MenuDetailViewController
{
    WBExpandHeader *_header;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.liaosDict[@"list_t"] count]>0)
    {
        self.navigationController.navigationBarHidden = YES;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_RGB(234, 234, 234);
    _detailTabelRowHeight = 100.0f;
    
    
    [self.view addSubview:self.detailTable];
    [self.view addSubview:self.favoriteView];
    _headerView = [self.detailTable dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    _headerView.dishNameLable.text = self.titleStr;
    [_headerView loadUIWithDictionary:self.liaosDict];
    if ([self.liaosDict[@"list_t"] count]>0)
    {
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_WIDTH)];
        [titleImageView sd_setImageWithURL:[NSURL URLWithString:self.titlePicStr] placeholderImage:[UIImage imageNamed:@"meBackground.jpg"]];
        titleImageView.clipsToBounds = YES;
        titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _header = [WBExpandHeader expandWithScrollView:_detailTable expandView:titleImageView];
        [self.view addSubview:self.backBtn];
    }

}
- (UIView *)favoriteView
{
    if (!_favoriteView) {
        _favoriteView= [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40.0f, SCREEN_WIDTH, 40.0f)];
        _favoriteView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
        __block UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        favoriteBtn.frame = CGRectMake((SCREEN_WIDTH-150.0f)/2, 1.0f, 150.0f, 38.0f);
        [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"cd_scbtn.png"] forState:UIControlStateNormal];
        [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"cd_yscbtn.png"] forState:UIControlStateSelected];
        [self.favoriteArr enumerateObjectsUsingBlock:^(RecipeModel *obj, NSUInteger idx, BOOL *stop) {
            if (*stop == NO) {
                if (obj.menuId == self.recipe.menuId)
                {
                    favoriteBtn.selected = YES;
                    *stop = YES;
                }else
                {
                    favoriteBtn.selected = NO;
                }
            }
            
        }];
        [favoriteBtn addTarget:self action:@selector(favoriteMeishi:) forControlEvents:UIControlEventTouchUpInside];
        [_favoriteView addSubview:favoriteBtn];
        
    }
    return _favoriteView;
}
- (void)favoriteMeishi:(UIButton *)sender
{
    if (sender.selected == YES)
    {
        __block NSInteger favoriteIndex;
        [self.favoriteArr enumerateObjectsUsingBlock:^(RecipeModel *obj, NSUInteger idx, BOOL *stop) {
            if (obj.menuId == self.recipe.menuId)
            {
                favoriteIndex = idx;
            }
        }];
        [self.favoriteArr removeObjectAtIndex:favoriteIndex];
        sender.selected = NO;
    }else
    {
        [self.favoriteArr addObject:self.recipe];
        sender.selected = YES;
    }
    [NSKeyedArchiver archiveRootObject:self.favoriteArr toFile:FAVORITE];
}
- (NSMutableArray *)favoriteArr
{
    if (!_favoriteArr)
    {
        _favoriteArr = [NSKeyedUnarchiver unarchiveObjectWithFile:FAVORITE];
        if (_favoriteArr == nil) {
            _favoriteArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return _favoriteArr;
}
- (UITableView *)detailTable
{
    if (!_detailTable) {
        _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f) style:UITableViewStyleGrouped];
        if ([self.liaosDict[@"list_t"] count]>0)
        {
            _detailTable.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        _detailTable.backgroundColor = COLOR_RGB(234, 234, 234);
        _detailTable.delegate = self;
        _detailTable.dataSource = self;
        _detailTable.separatorStyle = UITableViewCellAccessoryNone;
        
        [_detailTable registerClass:[MenuDetailCell class] forCellReuseIdentifier:@"cell"];
        [_detailTable registerClass:[CookerDetailHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return _detailTable;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateHighlighted];
        _backBtn.frame = CGRectMake(16, 26, 36, 36);
        _backBtn.layer.cornerRadius = 18.0;
        _backBtn.clipsToBounds = YES;
        [_backBtn setBackgroundColor:[UIColor WTcolorWithHexString:@"#666666"]];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark--UITabelViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [detailCell loadingDetailMenuWithDict:self.detailArr[indexPath.row]];
    _detailTabelRowHeight = detailCell.detailTableRowHeight;
    return detailCell;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _detailTabelRowHeight;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.liaosDict[@"list_t"] count]>0) {
        return _headerView.headerViewHeight;
    }else
    {
        return 44.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([self.liaosDict[@"list_t"] count]>0)
    {
        
        return _headerView;
        
    }else
    {
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, SCREEN_WIDTH-20.0f, 24.0f)];
        titleLabel.font = FONT(18.0f);
        titleLabel.text = self.titleStr;
        [labelView addSubview:titleLabel];
        return labelView;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
