//
//  MenuFavoriteViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuFavoriteViewController.h"
#import "MenuDetailViewController.h"
#import "MenuListCell.h"
#import "CookMenu_Header.h"
@interface MenuFavoriteViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *favoriteTable;
@property(nonatomic,strong)NSMutableArray *favoriteArr;
@property(nonatomic,strong)UIBarButtonItem *rightBtnItem;
@end

@implementation MenuFavoriteViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _favoriteArr = nil;//重置数组 再次获得数据
    [self.favoriteTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    self.title = @"收藏";
    self.view.backgroundColor = UIColorFromRGB(0xe9e9e9);
    [self.view addSubview:self.favoriteTable];
}
- (UIBarButtonItem *)rightBtnItem
{
    if (!_rightBtnItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44.0f, 44.0f);
        [button setBackgroundImage:[UIImage imageNamed:@"delicon.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteFavorite) forControlEvents:UIControlEventTouchUpInside];
        _rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _rightBtnItem;
}
- (void)deleteFavorite
{
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您要删除所有收藏的美食吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.favoriteArr removeAllObjects];
        [NSKeyedArchiver archiveRootObject:self.favoriteArr toFile:FAVORITE];
        [self.favoriteTable reloadData];
    }
}
- (NSMutableArray *)favoriteArr
{
    if (!_favoriteArr) {
        _favoriteArr = [NSKeyedUnarchiver unarchiveObjectWithFile:FAVORITE];
        if (_favoriteArr == nil) {
            _favoriteArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return _favoriteArr;
}
#pragma mark--创建表
- (UITableView *)favoriteTable
{
    if (!_favoriteTable) {
        _favoriteTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f-49.0f) style:UITableViewStylePlain];
        _favoriteTable.delegate = self;
        _favoriteTable.dataSource = self;
        _favoriteTable.backgroundColor = UIColorFromRGB(0xe9e9e9);
        _favoriteTable.rowHeight = 110.0f;
        _favoriteTable.tableFooterView = [UIView new];
        [_favoriteTable registerClass:[MenuListCell class] forCellReuseIdentifier:@"cell"];
    }
    if (self.favoriteArr.count>0) {
        _favoriteTable.backgroundView = nil;
    }else
    {
        _favoriteTable.backgroundView = [self tableBackgroundView];
    }
    return _favoriteTable;
}
#pragma mark--创建表的背景
- (UIView *)tableBackgroundView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _favoriteTable.frame.size.width, _favoriteTable.frame.size.height)];
    backgroundView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1.0f, SCREEN_WIDTH, 40.0f)];
    label.textColor = COLOR_RGB(83, 83, 83);
    label.font = FONT(15.0f);
    label.numberOfLines = 0;
    label.text = @"亲，您还没有收藏菜单哦！\n可以去首页收藏自己喜欢的美食哦！";
    label.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:label];
    return backgroundView;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadingMenuListWith:self.favoriteArr[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favoriteArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeModel *recipe = self.favoriteArr[indexPath.row];
    NSData *stringData = [recipe.zuofa dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *zuofanArray = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingMutableLeaves error:nil];
    
    NSData *liaosData = [recipe.liaos dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *liaosDict = [NSJSONSerialization JSONObjectWithData:liaosData options:NSJSONReadingMutableLeaves error:nil];
    
    NSData *authorData = [recipe.author dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *authorDict = [NSJSONSerialization JSONObjectWithData:authorData options:NSJSONReadingMutableLeaves error:nil];
    
    MenuDetailViewController *detailVC = [MenuDetailViewController new];
    detailVC.authorDict = authorDict;
    detailVC.liaosDict = liaosDict;
    detailVC.detailArr = zuofanArray;
    detailVC.titlePicStr = recipe.titlepic;
    detailVC.titleStr = recipe.title;
    detailVC.recipe = recipe;
    [self.navigationController pushViewController:detailVC animated:YES];
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
