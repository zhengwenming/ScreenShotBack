//
//  BaseViewController.h
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势

@end
