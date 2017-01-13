//
//  WithoutNavigationBarViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 17/1/13.
//  Copyright © 2017年 郑文明. All rights reserved.
//

#import "WithoutNavigationBarViewController.h"

@interface WithoutNavigationBarViewController ()

@end

@implementation WithoutNavigationBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationController.navigationBarHidden = YES;
    
    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    if (self.enablePanGesture) {
        self.navigationItem.title = @"手势打开,导航隐藏";
        aLabel.text = @"返回手势已打开，导航隐藏";
    }else{
        self.navigationItem.title = @"手势已经关闭,导航隐藏";
        aLabel.text = @"返回手势已经关闭，导航隐藏";
        UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aBtn.frame = CGRectMake(20, aLabel.frame.origin.y+aLabel.frame.size.height+60, self.view.frame.size.width-2*20, 50);
        [aBtn setTitle:@"pop" forState:UIControlStateNormal];
        [aBtn setTitle:@"pop" forState:UIControlStateSelected];
        aBtn.backgroundColor = [UIColor redColor];
        [aBtn addTarget:self action:@selector(popOut:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aBtn];
    }
    aLabel.backgroundColor = [UIColor redColor];
    aLabel.userInteractionEnabled = YES;
    aLabel.center = self.view.center;
    [self.view addSubview:aLabel];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheLabel:)];
    [aLabel addGestureRecognizer:tap];
    
    
    
    
   
}

-(void)popOut:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark tapTheLabel
-(void)tapTheLabel:(UITapGestureRecognizer *)sender{
    WithoutNavigationBarViewController *nonNavBarVC = [[WithoutNavigationBarViewController alloc]init];
    [self.navigationController pushViewController:nonNavBarVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

