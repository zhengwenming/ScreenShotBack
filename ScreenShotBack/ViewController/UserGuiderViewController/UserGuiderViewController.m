//
//  UserGuiderViewController.m
//  ScreenShotBack
//
//  Created by zhengwenming on 16/6/11.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "UserGuiderViewController.h"
#define imageViewCount  3
@interface UserGuiderViewController ()
@property (nonatomic,strong)UIScrollView  *rootScrollView;
@property (nonatomic,strong)UIButton  *startButton;
@property (nonatomic,weak)UIImageView   *versionImage;

@end

@implementation UserGuiderViewController
#pragma mark-Action
- (void)start:(UIButton  *)button{
    [AppDelegate shareAppDelegate].tabBarViewController = [[TabBarViewController alloc]init];
    [self presentViewController:[AppDelegate shareAppDelegate].tabBarViewController animated:YES completion:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view  addSubview:self.rootScrollView];

}
#pragma  mark-懒加载
- (UIScrollView *)rootScrollView{
    if (!_rootScrollView) {
        _rootScrollView=[[UIScrollView  alloc] initWithFrame:self.view.bounds];
        
        for (int i=0; i<imageViewCount; i++) {
            UIImageView  *imageview=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width)*i, 0,self.view.frame.size.width,self.view.frame.size.height)];
            NSString *imagename=[NSString  stringWithFormat:@"new_feature_%d", i + 1];
            
            imageview.image=[UIImage imageNamed:imagename];
            [_rootScrollView  addSubview:imageview];
            if (i==imageViewCount-1) {
                imageview.userInteractionEnabled = YES;
                self.versionImage=imageview;
                [imageview addSubview:self.startButton];
            }
            _rootScrollView.contentSize=CGSizeMake(imageViewCount*(self.view.frame.size.width), self.view.frame.size.height);
            _rootScrollView.pagingEnabled=YES;
            _rootScrollView.showsVerticalScrollIndicator=NO;
            _rootScrollView.showsHorizontalScrollIndicator=NO;
            _rootScrollView.bounces=NO;
            
        }
    }
    
    return _rootScrollView;
}
-(UIButton *)startButton{
    if (!_startButton) {
        _startButton=[[UIButton  alloc] init];
        [_startButton setTitle:@"立即体验" forState:   UIControlStateNormal];
        _startButton.backgroundColor = [UIColor lightGrayColor];
        _startButton.titleLabel.contentMode=NSTextAlignmentCenter;
        [_startButton setBackgroundImage:[UIImage imageNamed:@"NewVersionNor"] forState:UIControlStateNormal];
        [_startButton setBackgroundImage:[UIImage  imageNamed:@"NewVersionSel"] forState: UIControlStateHighlighted];
        _startButton.frame = CGRectMake(40, self.view.frame.size.height-140, self.view.frame.size.width-40*2, 40);
        [_startButton  addTarget:self action:@selector(start:) forControlEvents: UIControlEventTouchUpInside];
    }
    return  _startButton;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
