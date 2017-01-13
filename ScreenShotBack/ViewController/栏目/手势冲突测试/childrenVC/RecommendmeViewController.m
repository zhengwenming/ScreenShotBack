//
//  RecommendmeViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 17/1/13.
//  Copyright © 2017年 郑文明. All rights reserved.
//

#import "RecommendmeViewController.h"
#import "DetailViewController.h"

@interface RecommendmeViewController ()

@end

@implementation RecommendmeViewController
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor brownColor];
    
    [super viewDidLoad];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-20*2, 40)];
    aLabel.text = @"我是推荐，点击push到detailVC";
    aLabel.center = self.view.center;
    aLabel.backgroundColor = [UIColor magentaColor];
    aLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:aLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailViewController:)];
    aLabel.userInteractionEnabled = YES;
    [aLabel addGestureRecognizer:tap];
}
-(void)showDetailViewController:(UITapGestureRecognizer *)sender{
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end

