
/*!
 @header DetailViewController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/3/13
 
 @version 1.00 16/3/13 Creation(版本信息)
 
   Copyright © 2016年 zhengwenming. All rights reserved.
 */

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    aLabel.text = @"我是详情页面";
    aLabel.center = self.view.center;
    aLabel.backgroundColor = [UIColor magentaColor];
    aLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:aLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailViewController:)];
    aLabel.userInteractionEnabled = YES;
    [aLabel addGestureRecognizer:tap];

}
-(void)showDetailViewController:(UITapGestureRecognizer *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    NSLog(@"DetailViewController dealloc");
}

@end
