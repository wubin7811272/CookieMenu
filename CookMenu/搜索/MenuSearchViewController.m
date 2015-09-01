//
//  MenuSearchViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuSearchViewController.h"
#import "MenuListViewController.h"
#import "CookMenu_Header.h"


@interface MenuSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISearchBar *dishMenuSearchBar;//搜索框
@property(nonatomic,strong)UITableView *searchRecordTable;//搜索结果表
@property(nonatomic,strong)UIButton *emptyBtn;//清空搜索按钮
@property(nonatomic,strong)NSMutableArray *historySearchStrArr;//搜索历史数据
@property(nonatomic,strong)UILabel *promteLabel;//提示文字
@end

@implementation MenuSearchViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.dishMenuSearchBar];
    [self.searchRecordTable reloadData];

}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self.dishMenuSearchBar removeFromSuperview];
    self.dishMenuSearchBar.text = @"";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.searchRecordTable];
}

- (NSMutableArray *)historySearchStrArr
{
    if (!_historySearchStrArr) {
        _historySearchStrArr = [[NSMutableArray alloc] initWithContentsOfFile:HISTORY_SEARCH];
        if (_historySearchStrArr == nil) {
            _historySearchStrArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return _historySearchStrArr;
}
#pragma mark--创建表
- (UITableView *)searchRecordTable
{
    if (!_searchRecordTable) {
        _searchRecordTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f-49.0f) style:UITableViewStyleGrouped];
        _searchRecordTable.delegate = self;
        _searchRecordTable.dataSource = self;
        _searchRecordTable.backgroundColor = UIColorFromRGB(0xe9e9e9);
        
        
    }
    if (self.historySearchStrArr.count>0) {
        _searchRecordTable.backgroundView = nil;
    }else
    {
        _searchRecordTable.backgroundView = [self tableBackgroundView];
    }
    return _searchRecordTable;
}
#pragma mark--创建表的背景
- (UIView *)tableBackgroundView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchRecordTable.frame.size.width, _searchRecordTable.frame.size.height)];
    backgroundView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1.0f, SCREEN_WIDTH, 40.0f)];
    label.textColor = COLOR_RGB(83, 83, 83);
    label.text = @"亲，您还没有搜索哦！！！";
    label.font = FONT(15.0f);
    label.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:label];
    return backgroundView;
    
}
#pragma mark--创建搜索控件
- (UISearchBar *)dishMenuSearchBar
{
    if (!_dishMenuSearchBar) {
        _dishMenuSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 44)];
        _dishMenuSearchBar.searchBarStyle = UISearchBarStyleProminent;
        _dishMenuSearchBar.placeholder = @"菜谱名、食材名";
        _dishMenuSearchBar.delegate = self;
    }
    return _dishMenuSearchBar;
}
#pragma mark--UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self pushToListViewControllWithSQL:searchBar.text];
    
    __block NSUInteger stringIndex;
    __block BOOL isReloadArr = YES;
    [self.historySearchStrArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        if ([searchBar.text isEqualToString:obj]) {
            stringIndex = idx;
            isReloadArr = NO;
        }
    }];
    if (isReloadArr == YES) {
        if (self.historySearchStrArr.count==5) {
            [self.historySearchStrArr removeLastObject];
        }
        [self.historySearchStrArr insertObject:searchBar.text atIndex:0];
    }else
    {
        [self.historySearchStrArr removeObjectAtIndex:stringIndex];
        [self.historySearchStrArr insertObject:searchBar.text atIndex:0];
    }
    
    [self.historySearchStrArr writeToFile:HISTORY_SEARCH atomically:YES];
}

#pragma mark--UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.historySearchStrArr[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historySearchStrArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.historySearchStrArr.count>0) {
        return 75.0f;
    }else
    {
        return 0.01f;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.historySearchStrArr.count>0)
    {
        UIView *view = [self creatFooterView];
        return view;
    }else
    {
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushToListViewControllWithSQL:self.historySearchStrArr[indexPath.row]];
}
#pragma mark--创建表的footerView
- (UIView *)creatFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 75.0f)];
    footerView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SCREEN_WIDTH-159.0f)/2, (75.0f-39.0f)/2, 159.0f, 39.0f);
    [button addTarget:self action:@selector(cleanHistory) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xff5151) forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0f;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = UIColorFromRGB(0xff5151).CGColor;
    button.layer.masksToBounds = YES;
    [footerView addSubview:button];
    return footerView;
}
#pragma mark--清除历史记录
- (void)cleanHistory
{
    [self.historySearchStrArr removeAllObjects];
    [self.searchRecordTable reloadData];
    [self.historySearchStrArr writeToFile:HISTORY_SEARCH atomically:YES];
}

#pragma mark--push到列表的页面的公用方法
- (void)pushToListViewControllWithSQL:(NSString *)searchText
{
    NSString *sqlStr = [NSString stringWithFormat:@"where  title like '%%%@%%'",searchText];
    MenuListViewController *listVC = [[MenuListViewController alloc] init];
    listVC.sqlStr = sqlStr;
    listVC.title = searchText;
    listVC.isSearch = YES;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]init];
    barButtonItem.title=@"搜索";
    self.navigationItem.backBarButtonItem = barButtonItem;
    [self.navigationController pushViewController:listVC animated:YES];
}
#pragma mark--UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.dishMenuSearchBar endEditing:YES];
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
