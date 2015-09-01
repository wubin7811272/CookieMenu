//
//  MenuClassViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuClassViewController.h"
#import "MenuBtn.h"
#import "CookMenu_Header.h"
#import "MenuListViewController.h"
#import "FoodDataViewController.h"
#import "MenuCell.h"
@interface MenuClassViewController ()<UITableViewDataSource,UITableViewDelegate,MenuCellDelegate>
{
    NSArray *_allArr;
    BOOL _isShow;//控制标的站粘性
    BOOL _isOpen[4];//控制表的展开
}
@property(nonatomic,strong)UITableView *listTable;
@end

@implementation MenuClassViewController
const CGFloat __sectionHeight = 130.0f;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"分类";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CategoryList" ofType:@"txt"];
    //获取数据NSData，URL：fileURLWithPath
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    _allArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    [self.view addSubview:self.listTable];
    
}
- (UITableView *)listTable
{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f-49.0f) style:UITableViewStyleGrouped];
        _listTable.backgroundColor = COLOR_RGB(234, 234, 234);
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.separatorStyle = UITableViewCellAccessoryNone;
        [_listTable registerClass:[MenuCell class] forCellReuseIdentifier:@"cell"];

    }
    return _listTable;
}

#pragma mark--打开区
static MenuBtn *__clickBtn;//记录当前点击的按钮
- (void)openRow:(MenuBtn *)sender
{
    __clickBtn = sender;
    
    _isOpen[0] = NO;
    _isOpen[1] = NO;
    _isOpen[2] = NO;
    _isOpen[3] = NO;
    
    _isOpen[sender.section] = YES;
    _isShow = YES;
    
    [_listTable reloadData];
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:__clickBtn.section];
    [_listTable scrollToRowAtIndexPath:scrollIndexPath
                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark--UITableViewDelegate
//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadCookMenuWithArr:[[_allArr[indexPath.section] objectAtIndex:__clickBtn.row] objectForKey:@"d"] selectBtnIdex:__clickBtn.row];
    __rowHeight = cell.cellRowHeight;
    cell.delegate = self;
    return cell;
}
- (void)didSelectMenuWithIndex:(NSInteger)index
{
    
    if (__clickBtn.section==2&&__clickBtn.row==2)
    {
        NSLog(@"材料");
        NSArray *allArr = [[_allArr[__clickBtn.section] objectAtIndex:__clickBtn.row] objectForKey:@"d"];
        NSDictionary *foodDataDict = allArr[index];
        NSArray *foodDataArr = foodDataDict[@"d"];
        FoodDataViewController *dataVC = [FoodDataViewController new];
        dataVC.title = foodDataDict[@"t"];
        dataVC.foodArr = foodDataArr;
        [self.navigationController pushViewController:dataVC animated:YES];
    }else
    {
        NSArray *selectArr = [[_allArr[__clickBtn.section] objectAtIndex:__clickBtn.row] objectForKey:@"d"];
        MenuListViewController *listVC = [MenuListViewController new];
        listVC.title = [selectArr[index] objectForKey:@"t"];
        listVC.sqlStr = [selectArr[index] objectForKey:@"sql"];
        listVC.sqlArr = selectArr;
        //当前点击的所有类别的名称
        NSMutableArray *classArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dict in selectArr) {
            [classArr addObject:dict[@"t"]];
        }
        listVC.classArr = classArr;
        [self.navigationController pushViewController:listVC animated:YES];
    }
    
}
//行高
static CGFloat __rowHeight = 0.0f;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return __rowHeight;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isOpen[section]==NO?0:1;
}
//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allArr.count;
}
//自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, __sectionHeight)];
    view.backgroundColor = COLOR_RGB(234, 234, 234);
    CGFloat buttonWidth = (SCREEN_WIDTH-40.0f)/3;
    CGFloat buttonHeight = 120.0f;
    
    for (int i=0; i<3; i++) {
        MenuBtn *button = [MenuBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10.0f+i*(buttonWidth+10.0f), 10.0f, buttonWidth, buttonHeight);
        //记录当前的button是哪一个
        button.section = section;
        button.row = i;
        
        [button addTarget:self action:@selector(openRow:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, buttonWidth, buttonWidth)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lm_%ld%d",(long)section,i+1]];
        [button addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonWidth, buttonWidth, buttonHeight-buttonWidth)];
        label.font = FONT(14.0f);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [[_allArr[section] objectAtIndex:i] objectForKey:@"t"];
        label.textColor = COLOR_RGB(83, 83, 83);
        [button addSubview:label];
        
    }
    return view;
}

//区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __sectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _isOpen[indexPath.section] = NO;
   [self.listTable reloadSections: [NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation: UITableViewRowAnimationFade];
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
