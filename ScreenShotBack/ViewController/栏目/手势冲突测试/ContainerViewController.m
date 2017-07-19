
/*!
 @header ContainerViewController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/3/13
 
 @version 1.00 16/3/13 Creation(版本信息)
 
   Copyright © 2016年 zhengwenming. All rights reserved.
 */
#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif
#import "ContainerViewController.h"
#import "NearbyViewController.h"
#import "SquareViewController.h"
#import "RecommendmeViewController.h"

@interface ContainerViewController ()<UIScrollViewDelegate>{
    NearbyViewController *nearbyVC;
    SquareViewController *sqareVC;
    RecommendmeViewController *recommendVC;
    UIScrollView *mainScrollView;
    UIView *navView;
    UILabel *sliderLabel;
    UIButton *nearbyBtn;
    UIButton *squareBtn;
    UIButton *recommendBtn;
}

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation ContainerViewController
#pragma mark
#pragma mark 懒加载三个VC

-(NearbyViewController *)nearbyVC{
    if (nearbyVC==nil) {
        nearbyVC = [[NearbyViewController alloc]init];
        nearbyVC.navigationController = self.navigationController;
    }
    return nearbyVC;
}
-(SquareViewController *)sqareVC{
    if (sqareVC==nil) {
        sqareVC = [[SquareViewController alloc]init];
        sqareVC.navigationController = self.navigationController;

    }
    return sqareVC;
}
-(RecommendmeViewController *)recommendVC{
    if (recommendVC==nil) {
        recommendVC = [[RecommendmeViewController alloc]init];
        recommendVC.navigationController = self.navigationController;
    }
    return recommendVC;
}

#pragma mark 
#pragma mark 初始化三个UIButton和一个滑动的silderLabel，三个btn放到一个UIView（navView）上面。
-(void)initUI{

    navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearbyBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [nearbyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    nearbyBtn.frame = CGRectMake(0, 0, kScreenWidth/4, navView.frame.size.height);
    nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [nearbyBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [nearbyBtn setTitle:@"附近" forState:UIControlStateNormal];
    nearbyBtn.tag = 1;
    nearbyBtn.selected = YES;
    [navView addSubview:nearbyBtn];
    
    squareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    squareBtn.frame = CGRectMake(nearbyBtn.frame.origin.x+nearbyBtn.frame.size.width, nearbyBtn.frame.origin.y, kScreenWidth/4, navView.frame.size.height);
    [squareBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [squareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [squareBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [squareBtn setTitle:@"广场" forState:UIControlStateNormal];
    squareBtn.tag = 2;
    [navView addSubview:squareBtn];
    
    
    recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame = CGRectMake(squareBtn.frame.origin.x+squareBtn.frame.size.width, squareBtn.frame.origin.y, kScreenWidth/4, navView.frame.size.height);
    [recommendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recommendBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [recommendBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    recommendBtn.tag = 3;
    [navView addSubview:recommendBtn];
    
    sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40-2, kScreenWidth/4, 4)];
    sliderLabel.backgroundColor = [UIColor redColor];
    [navView addSubview:sliderLabel];
    
    self.navigationItem.titleView = navView;
    
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self initUI];
    [self setMainSrollView];
    //设置默认
    [self sliderWithTag:self.currentIndex+1];
}
#pragma mark
#pragma mark 初始化srollView
-(void)setMainSrollView{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = NO;//弹簧效果
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    NSArray *views = @[self.nearbyVC.view,self.sqareVC.view,self.recommendVC.view];
    for (NSInteger i = 0; i<views.count; i++) {
        //把三个vc的view依次贴到mainScrollView上面
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height-100)];
        [pageView addSubview:views[i]];
        [mainScrollView addSubview:pageView];
    }
    mainScrollView.contentSize = CGSizeMake(kScreenWidth*(views.count), 0);
    //滚动到_currentIndex对应的tab
    [mainScrollView setContentOffset:CGPointMake((mainScrollView.frame.size.width)*_currentIndex, 0) animated:YES];
}
-(UIButton *)buttonWithTag:(NSInteger )tag{
    if (tag==1) {
        return nearbyBtn;
    }else if (tag==2){
        return squareBtn;
    }else if (tag==3){
        return recommendBtn;
    }else{
        return nil;
    }
}
-(void)sliderAction:(UIButton *)sender{
    if (self.currentIndex==sender.tag) {
        return;
    }
    [self sliderAnimationWithTag:sender.tag];
    mainScrollView.contentOffset = CGPointMake(kScreenWidth*(sender.tag-1), 0);
}
-(void)sliderAnimationWithTag:(NSInteger)tag{
    self.currentIndex = tag;
    nearbyBtn.selected = NO;
    squareBtn.selected = NO;
    recommendBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        sliderLabel.frame = CGRectMake(sender.frame.origin.x, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    }];
}
-(void)sliderWithTag:(NSInteger)tag{
    self.currentIndex = tag;
    nearbyBtn.selected = NO;
    squareBtn.selected = NO;
    recommendBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
        sliderLabel.frame = CGRectMake(sender.frame.origin.x, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
        nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //实时计算当前位置,实现和titleView上的按钮的联动
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    CGFloat X = contentOffSetX * (3*kScreenWidth/4)/kScreenWidth/3;
    CGRect frame = sliderLabel.frame;
    frame.origin.x = X;
    sliderLabel.frame = frame;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
        int index_ = contentOffSetX/kScreenWidth;
    [self sliderWithTag:index_+1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
