//
//  YZDrawPaperProView.h
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/30.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZDrawTopView;

@interface YZDrawPaperProView : UIView

- (void)save;
- (void)undo;
- (void)redo;
- (void)clear;

+ (id)drawPaperProViewWithTopView:(YZDrawTopView *)topView;

@end
