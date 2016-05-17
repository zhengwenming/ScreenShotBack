//
//  NonNavgationBarViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/11.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "NonNavgationBarViewController.h"

@implementation NonNavgationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     打开手势返回，
     */
    self.navigationItem.title = @"手势打开,导航隐藏";
    self.enablePanGesture = YES;
    self.navigationController.navigationBarHidden = YES;
    
    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"返回手势已打开，导航隐藏";
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
    NonNavgationBarViewController *nonNavBarVC = [[NonNavgationBarViewController alloc]init];
    [self.navigationController pushViewController:nonNavBarVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

