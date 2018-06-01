//
//  ScreenShotBackConfig.h
//  ScreenShotBack
//
//  Created by 郑文明 on 16/11/1.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#ifndef ScreenShotBackConfig_h
#define ScreenShotBackConfig_h

// 打开边界后，放开，距离左边多少距离才触发pop
#define Distance_To_Pop 80
//左边多少距离能接受手势(默认是全屏都可以接受手势)
#define Left_Distance_Recieve_Gesture (([UIScreen mainScreen].bounds.size.width))

#define kAnimationDuration         0.3
#define kMaskViewAlpha             0.5
#define kTransformScale            0.95




#import "WMNavigationController.h"
#import "AppDelegate.h"


#endif /* ScreenShotBackConfig_h */
