//
//  BaseViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (id)init{
    self = [super init];
    if (self) {
        self.enablePanGesture = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
