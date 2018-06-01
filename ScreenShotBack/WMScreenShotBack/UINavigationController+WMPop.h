//
//  UINavigationController+WMPop.h
//  ScreenShotBack
//
//  Created by zhengwenming on 2018/6/1.
//  Copyright © 2018年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (WMPop)

- (void)wmPopViewControllerAnimated:(BOOL)animated;
- (void)wmPopToViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated;
- (void)wmPopToRootViewControllerAnimated:(BOOL)animated;

@end
