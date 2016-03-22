//
//  ViewController.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/18.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "ViewController.h"
#import "YZDrawView.h"

@interface ViewController ()

@property (nonatomic, weak) YZDrawView * drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YZDrawView * drawView = [YZDrawView drawView];
    [self.view addSubview:drawView];
    self.drawView = drawView;
}

//屏幕旋转调整视图大小

//下面这两种方法已经不推荐使用了，第一种旋转结束才调整视图没有动画，第二种有动画与控制器视图的动画不一致慢能看到控制器的视图
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    self.drawView.frame = self.view.frame;
//}
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    self.drawView.frame = self.view.frame;
//}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //NSLog(@" %@  %@",NSStringFromCGSize(size), NSStringFromCGRect(self.view.frame));
    
    CGRect viewFrame = self.drawView.frame;
    viewFrame.size = size;
    self.drawView.frame = viewFrame;
    
}

@end
