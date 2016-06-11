//
//  AppDelegate.h
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#if kUseScreenShotGesture
#import "ScreenShotView.h"
#endif
#import "TabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TabBarViewController *tabBarViewController;
#if kUseScreenShotGesture
@property (strong, nonatomic) ScreenShotView *screenshotView;
#endif

/// func
+ (AppDelegate* )shareAppDelegate;

@end

