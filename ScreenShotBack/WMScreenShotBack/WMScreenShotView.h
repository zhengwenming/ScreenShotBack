//
//  WMScreenShotView.h
//  ScreenShotBack
//
//  Created by zhengwenming on 2018/6/1.
//  Copyright © 2018年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMScreenShotView : UIView


@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *arrayImage;

- (void)showEffectChange:(CGPoint)pt;
- (void)restore;
- (void)screenShot;

@end
