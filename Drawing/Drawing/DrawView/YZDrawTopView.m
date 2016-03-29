//
//  YZDrawTopView.m
//  Drawing
//
//  Created by MA806P on 16/3/27.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawTopView.h"

@implementation YZDrawTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化子视图
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews
{
    UIButton * undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    undoBtn.frame = CGRectMake(10, 20, 44, 44);
    [undoBtn setImage:[UIImage imageNamed:@"undo"] forState:UIControlStateNormal];
    [undoBtn setImage:[UIImage imageNamed:@"undo_unable"] forState:UIControlStateDisabled];
    [undoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [undoBtn addTarget:self action:@selector(undoBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:undoBtn];
    self.undoBtn = undoBtn;
    self.undoBtn.enabled = NO;
    
    UIButton * redoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redoBtn.frame = CGRectMake(60, 20, 44, 44);
    [redoBtn setImage:[UIImage imageNamed:@"redo"] forState:UIControlStateNormal];
    [redoBtn setImage:[UIImage imageNamed:@"redo_unable"] forState:UIControlStateDisabled];
    [redoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [redoBtn addTarget:self action:@selector(redoBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:redoBtn];
    self.redoBtn = redoBtn;
    self.redoBtn.enabled = NO;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(110, 20, 44, 44);
    [saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];
    self.saveBtn = saveBtn;
    
    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(160, 20, 44, 44);
    [clearBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearBtn];
    self.clearBtn = clearBtn;
}


#pragma mark - 按钮处理事件

- (void)saveBtnTouch
{
    self.saveBlock();
}

- (void)undoBtnTouch
{
    self.undoBlock();
}

- (void)redoBtnTouch
{
    self.redoBlock();
}

- (void)clearBtnTouch
{
    self.clearBlock();
}


@end
