//
//  WMScreenShotView.m
//  ScreenShotBack
//
//  Created by zhengwenming on 2018/6/1.
//  Copyright © 2018年 郑文明. All rights reserved.
//

#import "WMScreenShotView.h"
#import <QuartzCore/QuartzCore.h>
static char szListenTabbarViewMove[] = "listenTabViewMove";

@implementation WMScreenShotView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrayImage = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor  clearColor];
        [self addSubview:self.imgView];
        [self addSubview:self.maskView];
        
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.window.rootViewController.view addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:szListenTabbarViewMove];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == szListenTabbarViewMove){
        NSValue *value  = [change objectForKey:NSKeyValueChangeNewKey];
        CGAffineTransform newTransform = [value CGAffineTransformValue];
        [self showEffectChange:CGPointMake(newTransform.tx, 0) ];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)showEffectChange:(CGPoint)pt{
    if (pt.x > 0){
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:-pt.x / ([UIScreen mainScreen].bounds.size.width) * kMaskViewAlpha + kMaskViewAlpha];
        self.imgView.transform = CGAffineTransformMakeScale(kTransformScale + (pt.x / ([UIScreen mainScreen].bounds.size.width) * (1-kTransformScale)), kTransformScale + (pt.x / ([UIScreen mainScreen].bounds.size.width) * (1-kTransformScale)));
    }
    if (pt.x < 0){
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskViewAlpha];
        self.imgView.transform = CGAffineTransformIdentity;
    }
}

- (void)restore{
    if (self.maskView && self.imgView){
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskViewAlpha];
        self.imgView.transform = CGAffineTransformMakeScale(kTransformScale, kTransformScale);
    }
}

- (void)screenShot{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    self.imgView.image = sendImage;
    self.imgView.transform = CGAffineTransformMakeScale(kTransformScale, kTransformScale);
}

- (void)dealloc{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window.rootViewController.view removeObserver:self forKeyPath:@"transform" context:szListenTabbarViewMove];
}
@end
