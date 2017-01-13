


//
//  ColumnViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "ColumnViewController.h"
#import "PanGestureViewController.h"
#import "WithoutPanGestureViewController.h"
#import "ContainerViewController.h"

@interface ColumnViewController ()
{
   
}

@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aBtn.frame = CGRectMake(20, 100, self.view.frame.size.width-2*20, 50);
    [aBtn setTitle:@"去测试手势冲突" forState:UIControlStateNormal];
    [aBtn setTitle:@"去测试手势冲突" forState:UIControlStateSelected];
    aBtn.backgroundColor = [UIColor redColor];
    aBtn.center = self.view.center;
    [aBtn addTarget:self action:@selector(gestureRecognizersConflictTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
}

-(void)gestureRecognizersConflictTest:(UIButton *)sender{
    ContainerViewController *containerVC = [ContainerViewController new];
    containerVC.currentIndex = 2;//注意⚠不要设置超过tab的个数，index从0开始。
    [self.navigationController pushViewController:containerVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
