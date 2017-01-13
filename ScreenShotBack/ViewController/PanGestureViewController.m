//
//  PanGestureViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "PanGestureViewController.h"

@interface PanGestureViewController ()

@end

@implementation PanGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     默认支持手势返回
     */
    self.navigationItem.title = @"打开手势";

    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"返回手势已打开";
    aLabel.backgroundColor = [UIColor redColor];
    aLabel.userInteractionEnabled = YES;
    aLabel.center = self.view.center;
    [self.view addSubview:aLabel];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheLabel:)];
    [aLabel addGestureRecognizer:tap];
}
-(void)tapTheLabel:(UITapGestureRecognizer *)sender{
    PanGestureViewController *panGesVC = [[PanGestureViewController alloc]init];
    [self.navigationController pushViewController:panGesVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
