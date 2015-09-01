//
//  FoodDataViewController.m
//  CookMenu
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "FoodDataViewController.h"
#import "CookMenu_Header.h"
#import "FoodDataCell.h"
@interface FoodDataViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _tableRowHeight;
}
@property(nonatomic,strong)UITableView *foodDataTable;
@end

@implementation FoodDataViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.foodDataTable];
}
- (UITableView *)foodDataTable
{
    if (!_foodDataTable)
    {
        _foodDataTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT-64.0f) style:UITableViewStyleGrouped];
        _foodDataTable.backgroundColor = COLOR_RGB(234, 234, 234);
        _foodDataTable.delegate = self;
        _foodDataTable.dataSource = self;
        _foodDataTable.separatorStyle = UITableViewCellAccessoryNone;
        _foodDataTable.backgroundColor = UIColorFromRGB(0xeeeeee);
        [_foodDataTable registerClass:[FoodDataCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _foodDataTable;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadingFoodDataWithDict:self.foodArr[indexPath.row]];
    _tableRowHeight = cell.foodDataTableRowHeight;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableRowHeight;
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
