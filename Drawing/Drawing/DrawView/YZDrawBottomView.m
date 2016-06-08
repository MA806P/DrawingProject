//
//  YZDrawBottomView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/4/7.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawBottomView.h"

const CGFloat LineWidthMax = 30.0;

@interface YZDrawBottomView ()

@property (nonatomic, strong) UIView * settingView;

@property (nonatomic, weak) UIButton * lineWidthBtn;
@property (nonatomic, weak) UIImageView * lineWImgView;
@property (nonatomic, weak) UIButton * lineColorBtn;
@property (nonatomic, weak) UIButton * lineEraserBtn;

@property (nonatomic, weak) UIView * lineWidthView;
@property (nonatomic, weak) UIView * lineColorView;

@property (nonatomic, copy) NSString * settingFlag;

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
    self.settingView = [[UIView alloc] init];
    self.settingView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.settingView];
    
    
    CGFloat btnY = 10;
    CGFloat btnW = 30;
    CGFloat btnH = 30;
    CGFloat margin = 20;
    
    //线条宽度按钮，点击设置线宽度
    UIButton * lineWidthBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, btnY, btnW, btnH)];
    lineWidthBtn.contentMode = UIViewContentModeScaleAspectFit;
    [lineWidthBtn setImage:[UIImage imageNamed:@"large_dot"] forState:UIControlStateNormal];
    [lineWidthBtn addTarget:self action:@selector(lineWidthBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingView addSubview:lineWidthBtn];
    self.lineWidthBtn = lineWidthBtn;
    
    //线条颜色按钮，点击设置线的颜色
    UIButton * lineColorBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineWidthBtn.frame)+margin, btnY, btnW, btnH)];
    [lineColorBtn setImage:[UIImage imageNamed:@"palette"] forState:UIControlStateNormal];
    [lineColorBtn addTarget:self action:@selector(lineColorBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingView addSubview:lineColorBtn];
    self.lineColorBtn = lineColorBtn;
    
    //橡皮擦按钮，点击可进行擦拭线条
    UIButton * lineEraserBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineColorBtn.frame)+margin, btnY, btnW, btnH)];
    [lineEraserBtn setImage:[UIImage imageNamed:@"erase"] forState:UIControlStateNormal];
    [lineEraserBtn addTarget:self action:@selector(lineEraserBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingView addSubview:lineEraserBtn];
    self.lineEraserBtn = lineEraserBtn;
    
    
    
    
    //设置线宽的视图
    CGFloat lineWSetViewMargin = 5;
    CGFloat lineWSetViewSliderW = 220;
    CGFloat lineWSetViewBtnW = 0.5*([UIScreen mainScreen].bounds.size.width - lineWSetViewMargin*2 - lineWSetViewSliderW);
    CGRect lineWidthSetViewFrame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 44);

    UIView * lineWidthView = [[UIView alloc] initWithFrame:lineWidthSetViewFrame];
    lineWidthView.backgroundColor = [UIColor clearColor];
    
    UIImageView * lineWImgView = [[UIImageView alloc] initWithFrame:CGRectMake(lineWSetViewMargin, btnY, lineWSetViewBtnW, btnH)];
    lineWImgView.contentMode = UIViewContentModeScaleAspectFit;
    lineWImgView.image = [UIImage imageNamed:@"large_dot"];
    lineWImgView.transform = CGAffineTransformMakeScale(self.lineWidth, self.lineWidth);
    [lineWidthView addSubview:lineWImgView];
    self.lineWImgView = lineWImgView;
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(lineWSetViewMargin+lineWSetViewBtnW, btnY, lineWSetViewSliderW, btnH)];
    slider.value = self.lineWidth;
    slider.maximumValue = LineWidthMax;
    slider.minimumValue = 1;
    
    [slider addTarget:self action:@selector(sliderLineWidthChange:) forControlEvents:UIControlEventValueChanged];
    [lineWidthView addSubview:slider];
    
    UIButton * lineWSetOKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lineWSetOKBtn.frame = CGRectMake(CGRectGetMaxX(slider.frame), btnY, btnW, btnH);
    [lineWSetOKBtn setTitle:@"OK" forState:UIControlStateNormal];
    [lineWSetOKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWSetOKBtn addTarget:self action:@selector(lineWidthSetOKBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [lineWidthView addSubview:lineWSetOKBtn];
    
    
    [self addSubview:lineWidthView];
    self.lineWidthView = lineWidthView;
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.settingFlag != nil) { return; }
    
    self.settingView.frame = self.bounds;
}


#pragma mark - 设置线宽

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    CGFloat lineWScale = self.lineWidth/LineWidthMax ;
    self.lineWImgView.transform = CGAffineTransformMakeScale(lineWScale, lineWScale);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWidthChangeNotification object:@(lineWidth)];
    
}


- (void)sliderLineWidthChange:(UISlider *)slider
{
    self.lineWidth = slider.value;
}


- (void)lineWidthSetOKBtnTouch
{
    CGRect showFrame = self.settingView.frame;
    showFrame.origin = CGPointMake(0, 0);
    CGRect hideFrame = showFrame;
    hideFrame.origin.y += showFrame.size.width;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.lineWidthView.frame = hideFrame;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.settingView.frame = showFrame;
        }];
        
    }];
}


- (void)lineWidthBtnTouch:(UIButton *)btn
{
    self.settingFlag = @"1";
    
    CGRect showFrame = self.settingView.frame;
    CGRect hideFrame = showFrame;
    hideFrame.origin.y += showFrame.size.width;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.settingView.frame = hideFrame;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.lineWidthView.frame = showFrame;
        }];
        
    }];
}




#pragma mark - 设置颜色等

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
