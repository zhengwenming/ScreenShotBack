
//
//  TabBarViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "TabBarViewController.h"
#import "RecommendViewController.h"
#import "ColumnViewController.h"
#import "OnlineViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.opaque = NO;
    self.tabBar.tintColor = RGB(244, 89, 27);
    [self initChildViewControllers];

}
-(void)initChildViewControllers
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    recommendVC.navigationItem.title = @"推荐";
    [recommendVC.tabBarItem setTitle:@"推荐"];
    [recommendVC.tabBarItem setImage:[UIImage imageNamed:@"推荐未选中"]];
    [recommendVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"推荐选中"]];
    BaseNavigationController *recommendNavC = [[BaseNavigationController alloc] initWithRootViewController:recommendVC];
    [childVCArray addObject:recommendNavC];
    
    ColumnViewController *columnVC = [[ColumnViewController alloc] init];
    columnVC.navigationItem.title = @"栏目";
    [columnVC.tabBarItem setTitle:@"栏目"];
    [columnVC.tabBarItem setImage:[UIImage imageNamed:@"栏目未选中"]];
    [columnVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"栏目选中"]];
    BaseNavigationController *columnNavC = [[BaseNavigationController alloc] initWithRootViewController:columnVC];
    [childVCArray addObject:columnNavC];
    
    OnlineViewController *onlineVC = [[OnlineViewController alloc] init];
    onlineVC.navigationItem.title = @"直播";
    [onlineVC.tabBarItem setTitle:@"直播"];
    [onlineVC.tabBarItem setImage:[UIImage imageNamed:@"直播未选中"]];
    [onlineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"直播选中"]];
    BaseNavigationController *onlineNavC = [[BaseNavigationController alloc] initWithRootViewController:onlineVC];
    [childVCArray addObject:onlineNavC];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.navigationItem.title = @"我的";
    [mineVC.tabBarItem setTitle:@"我的"];
    [mineVC.tabBarItem setImage:[UIImage imageNamed:@"我的未选中"]];
    [mineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"我的选中"]];
    BaseNavigationController *mineNavC = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    [childVCArray addObject:mineNavC];
    
    self.viewControllers = childVCArray;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
