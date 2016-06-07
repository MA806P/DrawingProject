//
//  YZDrawBottomView.h
//  Drawing
//
//  Created by 159CaiMini02 on 16/4/7.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZDrawBottomView : UIView

/** 线条宽度 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 线条颜色 */
@property (nonatomic, strong) UIColor * lineColor;

+ (id)drawBottomView;

@end
