//
//  RootTabBarViewController.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "MenuClassViewController.h"
#import "MenuSearchViewController.h"
#import "MenuFavoriteViewController.h"
@interface RootTabBarViewController ()
@property(nonatomic,strong)MenuClassViewController *classVC;
@property(nonatomic,strong)MenuSearchViewController *searchVC;
@property(nonatomic,strong)MenuFavoriteViewController *favoriteVC;
@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classVC = [MenuClassViewController new];
    self.searchVC = [MenuSearchViewController new];
    self.favoriteVC = [MenuFavoriteViewController new];
    
    self.viewControllers = @[[self viewControllerWithTab:self.classVC
                                                   Title:@"分类"
                                               imageName:@"menu_icon.png"
                                       selectedImageName:@"menued_icon.png"],
                             [self viewControllerWithTab:self.searchVC
                                                   Title:@"搜索"
                                               imageName:@"search_icon.png"
                                       selectedImageName:@"searched_icon.png"],
                             [self viewControllerWithTab:self.favoriteVC
                                                   Title:@"收藏"
                                               imageName:@"fav_icon.png"
                                       selectedImageName:@"faved_icon.png"]];
    
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UINavigationController*) viewControllerWithTab:(UIViewController *)viewController
                                           Title:(NSString *)title
                                       imageName:(NSString *)imgName
                               selectedImageName:(NSString *)selectedImgName
{
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    nav.tabBarItem = [self createTabBarItemWithTitle:title
                                           imageName:imgName
                                   selectedImageName:selectedImgName];
    
    return nav;
}
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title
                                  imageName:(NSString *)imgName
                          selectedImageName:(NSString *)selectedImgName
{
    UITabBarItem *tabbarItem = nil;
    UIImage *image = [UIImage imageNamed:imgName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImgName];
    
    
    tabbarItem = [[UITabBarItem alloc] initWithTitle:title
                                               image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                       selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    return tabbarItem;
}

@end
