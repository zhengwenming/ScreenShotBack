//
//  AppDelegate.h
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"

#warning 第一步

#if kUseScreenShotGesture
#import "ScreenShotView.h"
#endif


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TabBarViewController *tabBarViewController;
#warning 第二步

#if kUseScreenShotGesture
@property (nonatomic, strong) ScreenShotView *screenshotView;
#endif

/// func
+ (AppDelegate* )shareAppDelegate;

@end

