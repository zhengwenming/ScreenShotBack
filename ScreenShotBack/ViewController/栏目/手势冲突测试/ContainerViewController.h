/*!
 @header ContainerViewController.h
 
 @abstract  作者Github地址：https://github.com/zhengwenming
                    作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/3/13
 
 @version 1.00 16/3/13 Creation(版本信息)
 
   Copyright © 2016年 zhengwenming. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController
/**
 *  控制跳转到某个tab的参数，默认为0，就是第一个tab
 */
@property (nonatomic , assign) NSInteger currentIndex;

@end
