//
//  YZDrawPaperView.h
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/22.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZDrawTopView;

@interface YZDrawPaperView : UIView

@property (nonatomic, assign) CGFloat lineWidth;

- (void)save;
- (void)undo;
- (void)redo;
- (void)clear;

+ (id)drawPaperViewWithTopView:(YZDrawTopView *)topView;

@end
