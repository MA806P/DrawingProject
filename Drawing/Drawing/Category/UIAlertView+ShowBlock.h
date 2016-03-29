//
//  UIAlertView+ShowBlock.h
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/28.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowOKBlock)(NSInteger buttonIndex);

@interface UIAlertView (ShowBlock) <UIAlertViewDelegate>


- (void)showAlertViewWithOKBlock:(ShowOKBlock)block;

@end
