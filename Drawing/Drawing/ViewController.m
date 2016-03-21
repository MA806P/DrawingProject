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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YZDrawView * drawView = [YZDrawView drawView];
    [self.view addSubview:drawView];
    
}

@end
