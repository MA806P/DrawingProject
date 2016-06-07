//
//  YZDrawView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/21.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawView.h"
#import "YZDrawTopView.h"
#import "YZDrawPaperProView.h"
#import "YZDrawBottomView.h"

@interface YZDrawView ()

@property (nonatomic, weak) YZDrawTopView * topView;
@property (nonatomic, weak) YZDrawPaperProView * drawPaperView;
@property (nonatomic, weak) YZDrawBottomView * bottomView;

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
    
    __weak __typeof(self) unsafeSelf = self;
    
    //顶部视图
    YZDrawTopView * topView = [[YZDrawTopView alloc] init];
    topView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    topView.saveBlock = ^(){ [unsafeSelf.drawPaperView save]; };
    topView.undoBlock = ^(){ [unsafeSelf.drawPaperView undo]; };
    topView.redoBlock = ^(){ [unsafeSelf.drawPaperView redo]; };
    topView.clearBlock = ^(){ [unsafeSelf.drawPaperView clear]; };
    [self addSubview:topView];
    self.topView = topView;
    
    //中部视图
    //YZDrawPaperView * drawPaperView = [YZDrawPaperView drawPaperViewWithTopView:topView];
    YZDrawPaperProView * drawPaperView = [YZDrawPaperProView drawPaperProViewWithTopView:topView];
    drawPaperView.backgroundColor = [UIColor colorWithRed:0.800 green:0.910 blue:0.812 alpha:1.000];
    [self addSubview:drawPaperView];
    self.drawPaperView = drawPaperView;
    
    
    //底部视图
    YZDrawBottomView * bottomView = [YZDrawBottomView drawBottomView];
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
    NSLayoutConstraint * drawPaperViewBottom = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint * drawPaperViewLeft = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint * drawPaperViewRight = [NSLayoutConstraint constraintWithItem:self.drawPaperView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    
    
    [self addConstraints:@[drawPaperViewBottom, drawPaperViewLeft, drawPaperViewRight, drawPaperViewTop]];
}



- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"will move to superview");
    self.frame = newSuperview.frame;
}






@end
