# ScreenShotBack
截图手势返回，景深效果，类似斗鱼、天天快报、腾讯新闻等APP的手势返回。对于每个VC都可以关闭或者打开手势返回，一个属性搞定。

```Objective-C
    yourVC.enablePanGesture =  YES;（打开返回手势）默认为YES
    yourVC.enablePanGesture =   NO; （关闭返回手势）
    
    
     @interface BaseViewController : UIViewController
     @property (nonatomic, assign) BOOL enablePanGesture;//是否支持拖动pop手势，默认yes,支持手势

     @end
     
     
     @implementation BaseNavigationController

    这里可以改变触发的距离值
    // 打开边界多少距离才触发pop
    #define DISTANCE_TO_POP 80
```


# 注 ：隐藏的导航栏的返回效果自己看GIF，6666666.

![image](https://github.com/zhengwenming/ScreenShotBack/blob/master/ScreenShotBack/ScreenShotPop.gif)   

#欢迎加入iOS技术支持群479259423,进群请修改群名片格式。（2元付费群，手机端可以加，电脑加不了。慎入！）
