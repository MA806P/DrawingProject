//
//  YZDrawBottomView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/4/7.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawBottomView.h"

@interface YZDrawBottomView ()

@property (nonatomic, weak) UIButton * lineWidthBtn;
@property (nonatomic, weak) UIButton * lineColorBtn;
@property (nonatomic, weak) UIButton * lineEraserBtn;

@property (nonatomic, weak) UIView * lineWithView;
@property (nonatomic, weak) UIView * lineColorView;

@end

@implementation YZDrawBottomView

#pragma mark - init view

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化子视图
        [self initSubViews];
    }
    return self;
}


+(id)drawBottomView
{
    return [[self alloc] init];
}


#pragma mark - 初始化子视图

- (void)initSubViews
{
    CGFloat btnY = 10;
    CGFloat btnW = 30;
    CGFloat btnH = 30;
    CGFloat margin = 20;
    
    //线条宽度按钮，点击设置线宽度
    UIButton * lineWidthBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, btnY, btnW, btnH)];
    [lineWidthBtn setImage:[UIImage imageNamed:@"large_dot"] forState:UIControlStateNormal];
    [lineWidthBtn addTarget:self action:@selector(lineWidthBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lineWidthBtn];
    self.lineWidthBtn = lineWidthBtn;
    
    //线条颜色按钮，点击设置线的颜色
    UIButton * lineColorBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineWidthBtn.frame)+margin, btnY, btnW, btnH)];
    [lineColorBtn setImage:[UIImage imageNamed:@"palette"] forState:UIControlStateNormal];
    [lineColorBtn addTarget:self action:@selector(lineColorBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lineColorBtn];
    self.lineColorBtn = lineColorBtn;
    
    //橡皮擦按钮，点击可进行擦拭线条
    UIButton * lineEraserBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineColorBtn.frame)+margin, btnY, btnW, btnH)];
    [lineEraserBtn setImage:[UIImage imageNamed:@"erase"] forState:UIControlStateNormal];
    [lineEraserBtn addTarget:self action:@selector(lineEraserBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lineEraserBtn];
    self.lineEraserBtn = lineEraserBtn;
    
    
    
    
    //设置线宽的视图
    CGRect settingViewFrame = self.bounds;
    settingViewFrame.origin.y += settingViewFrame.size.height;
    
    UIView * lineWidthView = [[UIView alloc] initWithFrame:settingViewFrame];
    lineWidthView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:lineWidthView];
    
    
    
    
}


- (void)lineWidthBtnTouch:(UIButton *)btn
{
    CGRect colorBtnFrame = self.lineColorBtn.frame;
    CGRect eraserBtnFrame = self.lineEraserBtn.frame;
    colorBtnFrame.origin.y += 49;
    eraserBtnFrame.origin.y += 49;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.6 animations:^{
        weakSelf.lineColorBtn.frame = colorBtnFrame;
        weakSelf.lineEraserBtn.frame = eraserBtnFrame;
    } completion:^(BOOL finished) {
        UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        [weakSelf addSubview:slider];
    }];
}


- (void)lineColorBtnTouch:(UIButton *)btn
{
}

- (void)lineEraserBtnTouch:(UIButton *)btn
{
}

////隐藏画线的设置按钮
//- (void)hideSettingButton
//{
//    self.lineWidthBtn.hidden = YES;
//    self.lineColorBtn.hidden = YES;
//    self.lineEraserBtn.hidden = YES;
//}
////显示设置按钮
//- (void)showSettingButton
//{
//    self.lineWidthBtn.hidden = NO;
//    self.lineColorBtn.hidden = NO;
//    self.lineEraserBtn.hidden = NO;
//}
//
//#pragma mark - 画笔设置视图
//
//- (void)addChangeLineWidthView
//{
//    //隐藏设置按钮
//    [self hideSettingButton];
//    
//    
//}


@end
