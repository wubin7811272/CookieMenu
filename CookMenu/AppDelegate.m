//
//  AppDelegate.m
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "CookMenu_Header.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [RootTabBarViewController new];
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    [self changeTabBarStyle];

    return YES;
}
- (void)changeTabBarStyle
{
    
    //设置tabbar背景图片
//    [[UITabBar appearance] setBackgroundColor:[UIColor WTcolorWithHexString:@"#ffffff"]];
    
    //修改tabbarItem的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_RGB(83, 83, 83)}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_RGB(230, 51, 62)}
                                             forState:UIControlStateSelected];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT(18.0f),NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil]];
    [[UINavigationBar appearance] setBarTintColor:COLOR_RGB(245, 245, 245)];
    [[UINavigationBar appearance] setTintColor:COLOR_RGB(230, 51, 62)];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
