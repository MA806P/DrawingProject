//
//  YZDrawView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/21.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawView.h"
#import "YZDrawPaperView.h"

@interface YZDrawView ()

@property (nonatomic, weak) UIView * topView;
@property (nonatomic, weak) YZDrawPaperView * drawPaperView;
@property (nonatomic, weak) UIView * bottomView;

@end

@implementation YZDrawView


#pragma mark - 视图初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubViews];
    }
    return self;
}


+ (id)drawView
{
    return [[self alloc] init];
}


- (void)initSubViews
{
    
    NSLog(@"init subviews");
    
    //顶部视图
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self addSubview:topView];
    self.topView = topView;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(10, 20, 44, 44);
    [saveBtn setTitle:@"save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:saveBtn];
    
    UIButton * undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    undoBtn.frame = CGRectMake(60, 20, 44, 44);
    [undoBtn setTitle:@"undo" forState:UIControlStateNormal];
    [undoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [undoBtn addTarget:self action:@selector(undoBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:undoBtn];
    
    UIButton * redoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redoBtn.frame = CGRectMake(110, 20, 44, 44);
    [redoBtn setTitle:@"redo" forState:UIControlStateNormal];
    [redoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [redoBtn addTarget:self action:@selector(redoBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:redoBtn];
    
    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(160, 20, 44, 44);
    [clearBtn setTitle:@"clear" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:clearBtn];
    
    
    YZDrawPaperView * drawPaperView = [[YZDrawPaperView alloc] init];
    drawPaperView.backgroundColor = [UIColor colorWithRed:0.800 green:0.910 blue:0.812 alpha:1.000];
    [self addSubview:drawPaperView];
    self.drawPaperView = drawPaperView;
    
//    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
//    textField.backgroundColor = [UIColor brownColor];
//    [self.drawPaperView addSubview:textField];
    
    
    //底部视图
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    
    
}


#pragma mark - 视图布局

- (void)layoutSubviews
{
    NSLog(@"layout subviews");
    
    //顶部视图添加约束
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * topViewHeight = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:64];
    [self.topView addConstraint:topViewHeight];
    
    NSLayoutConstraint * topViewLeft = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    [self addConstraint:topViewLeft];
    
    NSLayoutConstraint * topViewTop = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self addConstraint:topViewTop];
    
    NSLayoutConstraint * topViewRight = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self addConstraint:topViewRight];
    
    
    //底部视图添加约束
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * bottomViewHeight = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:49];
    [self.bottomView addConstraint:bottomViewHeight];
    
    NSLayoutConstraint * bottomViewLeft = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    [self addConstraint:bottomViewLeft];
    
    NSLayoutConstraint * bottomViewBottom = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraint:bottomViewBottom];
    
    NSLayoutConstraint * bottomViewRight = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self addConstraint:bottomViewRight];
    
    
    //中间视图添加约束
    self.drawPaperView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * drawPaperViewTop = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint * drawPaperViewLeft = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint * drawPaperViewBottom = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint * drawPaperViewRight = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self addConstraints:@[drawPaperViewBottom, drawPaperViewLeft, drawPaperViewRight, drawPaperViewTop]];
}



- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"will move to superview");
    self.frame = newSuperview.frame;
}


#pragma mark - 按钮处理事件

- (void)saveBtnTouch
{
    [self.drawPaperView save];
}

- (void)undoBtnTouch
{
    [self.drawPaperView undo];
}

- (void)redoBtnTouch
{
    [self.drawPaperView redo];
}

- (void)clearBtnTouch
{
    [self.drawPaperView clear];
}

@end
