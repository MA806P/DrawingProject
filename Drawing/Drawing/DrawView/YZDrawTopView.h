//
//  YZDrawTopView.h
//  Drawing
//
//  Created by MA806P on 16/3/27.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopViewSaveBlock)();
typedef void(^TopViewUndoBlock)();
typedef void(^TopViewRedoBlock)();
typedef void(^TopViewClearBlock)();


@interface YZDrawTopView : UIView

@property (nonatomic, weak) UIButton * saveBtn;
@property (nonatomic, weak) UIButton * undoBtn;
@property (nonatomic, weak) UIButton * redoBtn;
@property (nonatomic, weak) UIButton * clearBtn;

@property (nonatomic, copy) TopViewSaveBlock saveBlock;
@property (nonatomic, copy) TopViewUndoBlock undoBlock;
@property (nonatomic, copy) TopViewRedoBlock redoBlock;
@property (nonatomic, copy) TopViewClearBlock clearBlock;

@end
