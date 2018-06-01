//
//  WMNavigationController.m
//  ScreenShotBack
//
//  Created by zhengwenming on 2018/6/1.
//  Copyright © 2018年 郑文明. All rights reserved.
//


// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
typedef NS_ENUM(NSInteger, WMPopType) {
    WMPopTypePopViewController,
    WMPopTypeToViewController,
    WMPopTypeToRootViewController
};


#import "WMNavigationController.h"

@interface WMNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (strong ,nonatomic) NSMutableArray *arrayScreenshot;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end

@implementation WMNavigationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arrayScreenshot = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //屏蔽系统的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.view addGestureRecognizer:self.panGesture];
}
///是否让这个手势起作用，生效，返回NO，无效，返回YES手势生效
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self.view) {
        if (self.topViewController.disablePanGesture){
            return NO;
        }else{
            CGPoint translate = [gestureRecognizer translationInView:self.view];
            BOOL possible = translate.x != 0 && fabs(translate.y) == 0;
            return possible;
        }
    }
    return NO;
}
///此方法可以解决滑动的冲突，
///举个栗子：侧滑返回和UIScrollView的本身滑动冲突了。再举个栗子：tableviewCell身上自带的系统删除，筛选界面展开的左滑事件有冲突
///下面详细解释此方法:
///同一个view上如果作用了两个相同类型的手势，那么系统默认只会响应一个，why？因为系统是SB，系统还没有这么智能的知道你想怎么样，他不会知道手势冲突的时候让那个接受手势，剩下的就是程序员的工作了，我们可以在此方法中判断，机制的做出明确的处理，该方法返回YES时，意味着所有相同类型的手势辨认都会得到处理。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")]|| [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPagingSwipeGestureRecognizer")]) {
        //冲突要有两个，二者不可兼得
        UIView *aView = otherGestureRecognizer.view;
        if ([aView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (UIScrollView *)aView;
            if (sv.contentOffset.x==0) {//判断依据
                return YES;
            }
        }
        return NO;
    }
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *rootVC = appdelegate.window.rootViewController;
    
    UINavigationController *nav= appdelegate.tabBarViewController.selectedViewController;
    UIViewController * currentVC = nav.topViewController;
    UIViewController * presentedVC = rootVC.presentedViewController;
    
    if (self.viewControllers.count == 1){
        return;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan){
        if (currentVC.gestureBeganBlock) {
            currentVC.gestureBeganBlock(currentVC);
        }
        appdelegate.screenshotView.hidden = NO;
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (currentVC.gestureChangedBlock) {
            currentVC.gestureChangedBlock(currentVC);
        }
        if (point_inView.x >= 10){
            rootVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
        }
    }else if (panGesture.state == UIGestureRecognizerStateEnded){
        if (currentVC.gestureEndedBlock) {
            currentVC.gestureEndedBlock(currentVC);
        }
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x >= Distance_To_Pop){
            [UIView animateWithDuration:kAnimationDuration animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
                presentedVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                appdelegate.screenshotView.hidden = YES;
            }];
        }else{
            [UIView animateWithDuration:kAnimationDuration animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appdelegate.screenshotView.hidden = YES;
            }];
        }
    }
    
}
//手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.topViewController.disablePanGesture)   return NO;
    if (self.viewControllers.count <= 1)            return NO;
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < Left_Distance_Recieve_Gesture) {//设置手势触发区
            return YES;
        }
    }
    return NO;
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray *arr = [super popToViewController:viewController animated:animated];
    if (self.arrayScreenshot.count > arr.count){
        for (int i = 0; i < arr.count; i++) {
            [self.arrayScreenshot removeLastObject];
        }
    }
    return arr;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 0){
        return [super pushViewController:viewController animated:animated];
    }else if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed = YES;//隐藏二级页面的tabbar
    }
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appdelegate.window.frame.size.width, appdelegate.window.frame.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.arrayScreenshot addObject:viewImage];
    appdelegate.screenshotView.imgView.image = viewImage;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.arrayScreenshot removeLastObject];
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.screenshotView.imgView.image = image;
        UIViewController *v = [super popViewControllerAnimated:animated];
        return v;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.arrayScreenshot.count > 2)
    {
        [self.arrayScreenshot removeObjectsInRange:NSMakeRange(1, self.arrayScreenshot.count - 1)];
    }
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.screenshotView.imgView.image = image;
        return [super popToRootViewControllerAnimated:animated];
}
- (void)wmPopViewControllerAnimated:(BOOL)animated{
    [self wmPopVC:nil popType:WMPopTypePopViewController animated:animated];
}

- (void)wmPopToViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated{
    [self wmPopVC:nil popType:WMPopTypeToViewController animated:animated];
}
- (void)wmPopToRootViewControllerAnimated:(BOOL)animated{
    [self wmPopVC:nil popType:WMPopTypeToRootViewController animated:animated];
}

-(void)wmPopVC:(UIViewController *)viewController popType:(WMPopType)popType animated:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    appDelegate.screenshotView.hidden = NO;
    appDelegate.screenshotView.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskViewAlpha];
    appDelegate.screenshotView.imgView.transform = CGAffineTransformMakeScale(kTransformScale, kTransformScale);
    [UIView animateWithDuration:animated?kAnimationDuration:0.f animations:^{
        rootVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
        presentedVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
    } completion:^(BOOL finished) {
        switch (popType) {
            case WMPopTypePopViewController:
                [self popViewControllerAnimated:NO];
                break;
            case WMPopTypeToViewController:
                [self popToViewController:viewController animated:NO];
                break;
            case WMPopTypeToRootViewController:
                [self popToRootViewControllerAnimated:NO];
                break;
            default:
                break;
        }
        rootVC.view.transform = CGAffineTransformIdentity;
        presentedVC.view.transform = CGAffineTransformIdentity;
        appDelegate.screenshotView.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end

