//
//  NonPanGestureViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "NonPanGestureViewController.h"

@interface NonPanGestureViewController ()

@end

@implementation NonPanGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     关闭手势返回
     */
    self.navigationItem.title = @"关闭手势";
    self.enablePanGesture = NO;

    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"返回手势已关闭";
    aLabel.backgroundColor = [UIColor redColor];
    aLabel.userInteractionEnabled = YES;
    aLabel.center = self.view.center;
    [self.view addSubview:aLabel];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheLabel:)];
    [aLabel addGestureRecognizer:tap];
}
#pragma mark 
#pragma mark tapTheLabel
-(void)tapTheLabel:(UITapGestureRecognizer *)sender{
    NonPanGestureViewController *nonPanGesVC = [[NonPanGestureViewController alloc]init];

    [self.navigationController pushViewController:nonPanGesVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
