//
//  MenuListViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuListViewController.h"
#import "MenuListCell.h"
#import "CookMenu_Header.h"
#import "CustomSegmentView.h"
#import "MenuDetailViewController.h"
@interface MenuListViewController ()<UITableViewDataSource,UITableViewDelegate,CustonSegmentDelegate>
{
    NSArray *_listArr;
    CGFloat _bottomViewHeight;
}
@property(nonatomic,strong)CustomSegmentView *topSegmentView;
@property(nonatomic,strong)CustomSegmentView *bottomSegmentView;;
@property(nonatomic,strong)UITableView *listTable;
@end

@implementation MenuListViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __dataSourceStr = nil;
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    [self.view addSubview:self.topSegmentView];
    if (self.isSearch == NO) {
        _bottomViewHeight = 50.0f;
        [self.view addSubview:self.bottomSegmentView];
    }else
    {
        _bottomViewHeight = 0.0f;
    }
    
    [SVProgressHUD show];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_RGB(234, 234, 234);

    [self performSelector:@selector(goToReload) withObject:nil afterDelay:1.0f];
}
- (void)goToReload
{
    _listArr = [DBManager getRecipeWithSQL:self.sqlStr recorder:nil];
    [SVProgressHUD dismiss];
    [self.view addSubview:self.listTable];
}
- (CustomSegmentView *)topSegmentView
{
    if (!_topSegmentView) {
        _topSegmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, 50.0f)];
        _topSegmentView.backgroundColor = COLOR_RGB(245, 245, 245);
        _topSegmentView.titles = @[@"默认",@"最新",@"收藏",@"人气"];
        _topSegmentView.delegate = self;
    }
    return _topSegmentView;
}
- (CustomSegmentView *)bottomSegmentView
{
    if (!_bottomSegmentView) {
        _bottomSegmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-_bottomViewHeight, SCREEN_WIDTH, _bottomViewHeight)];
        _bottomSegmentView.backgroundColor = COLOR_RGB(245, 245, 245);
        _bottomSegmentView.titles = self.classArr;
        __block NSInteger selectIndex;
        WEAKSELF
        [self.classArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            if ([title isEqualToString:weakSelf_SC.title]) {
                selectIndex = idx;
                return ;
            }
        }];
        _bottomSegmentView.selectIndex = selectIndex;
        _bottomSegmentView.delegate = self;
    }
    return _bottomSegmentView;
}
- (UITableView *)listTable
{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f+self.topSegmentView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f-(self.topSegmentView.frame.size.height+_bottomViewHeight)) style:UITableViewStylePlain];
        _listTable.backgroundColor = COLOR_RGB(234, 234, 234);
        _listTable.tableFooterView = [UIView new];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.rowHeight = 110.0f;
        [_listTable registerClass:[MenuListCell class] forCellReuseIdentifier:@"cell"];
    }
    if (_listArr.count>0) {
        _listTable.backgroundView = nil;
    }else
    {
        _listTable.backgroundView = [self tableBackgroundView];
    }
    return _listTable;
}
- (UIView *)tableBackgroundView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _listTable.frame.size.width, _listTable.frame.size.height)];
    backgroundView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0f, SCREEN_WIDTH, 40.0f)];
    label.textColor = COLOR_RGB(83, 83, 83);
    label.text = @"没有符合条件的菜谱哦，放宽条件试试吧";
    label.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:label];
    return backgroundView;
    
}
#pragma mark--CustomSegementViewDelegate
static NSString *__orderStr;//排序的sql语句
static NSString *__dataSourceStr;//获取数据的sql语句
- (void)clickSegmentBtn:(CustomSegmentView *)view type:(NSUInteger)btnIndex
{
    if (__dataSourceStr == nil) {
        __dataSourceStr = self.sqlStr;
    }
    if (view == _topSegmentView)
    {
        __orderStr = @[@"order by onclick desc",@"order by id desc",@"order by fav_num desc",@"order by photo_num desc"][btnIndex];
    }else
    {
        __dataSourceStr = [self.sqlArr[btnIndex] objectForKey:@"sql"];
        self.title = self.classArr[btnIndex];
    }
    _listArr = [DBManager getRecipeWithSQL:__dataSourceStr recorder:__orderStr];
    [self.listTable reloadData];
    if (_listArr.count>0) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_listTable scrollToRowAtIndexPath:scrollIndexPath
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}
#pragma mark--UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadingMenuListWith:_listArr[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeModel *recipe = _listArr[indexPath.row];
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
