//
//  UIAlertView+ShowBlock.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/28.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "UIAlertView+ShowBlock.h"
#import <objc/objc-runtime.h>



@implementation UIAlertView (ShowBlock) 

static char key;

- (void)showAlertViewWithOKBlock:(ShowOKBlock)block
{
    if (block)
    {
        //这里用到了runtime中绑定对象，将这个block对象绑定alertview上
        objc_setAssociatedObject(self, &key,block,OBJC_ASSOCIATION_COPY);
        //设置delegate
        self.delegate=self;
    }
    
    [self show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //拿到之前绑定的block对象
    ShowOKBlock block =objc_getAssociatedObject(self, &key);
    //移除所有关联
    objc_removeAssociatedObjects(self);
    if(block)
    {
        //调用block 传入此时点击的按钮index
        block(buttonIndex);
    }
}


@end
