//
//  YZDrawPaperProView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/30.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawPaperProView.h"
#import "YZDrawTopView.h"
#import "UIAlertView+ShowBlock.h"

@interface YZDrawPaperProView ()

/** 保存手指在屏幕上滑动的点 */
@property (nonatomic, strong) NSMutableArray * pathArray;

/** 画板的顶部视图 */
@property (nonatomic, strong) YZDrawTopView * topView;

@end

static NSUInteger stepCount = 0;

@implementation YZDrawPaperProView


- (NSMutableArray *)pathArray
{
    if (_pathArray == nil)
    {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

+ (id)drawPaperProViewWithTopView:(YZDrawTopView *)topView
{
    YZDrawPaperProView * paperView = [[self alloc] init];
    paperView.topView = topView;
    return paperView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawLineSetting:) name:LineWidthChangeNotification object:nil];
    }
    return self;
}
#pragma mark - 接收通知处理，设置画板属性线宽颜色等

- (void)drawLineSetting:(NSNotification *)notification
{
    //NSLog(@" --- %@", notification.object);
    
    self.lineWidth = [notification.object floatValue];
}




#pragma mark - 视图触摸处理

//开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当撤消后，再进行画线 清除缓存的撤销的路径
    NSUInteger pathArrayCount = self.pathArray.count;
    if(pathArrayCount>0 && pathArrayCount>stepCount)
    {
        [self.pathArray removeObjectsInRange:NSMakeRange(stepCount, pathArrayCount-stepCount)];
        self.topView.redoBtn.enabled = NO;
        self.topView.undoBtn.enabled = YES;
    }
    else
    {
        self.topView.undoBtn.enabled = YES;
    }
    
    //当手指按下时创建一条路径，设置路径的起点
    UITouch * beganTouch = [touches anyObject];
    CGPoint beganPoint = [beganTouch locationInView:self];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:beganPoint];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:self.lineWidth];
    
    //数组保存的手指滑动的路径
    [self.pathArray addObject:path];
    stepCount = self.pathArray.count;
}

//触摸滑动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取手指对应的触碰点
    UITouch * moveTouch = [touches anyObject];
    CGPoint movePoint = [moveTouch locationInView:self];
    
    //取出当前的路径，设置当前路径经过的点
    UIBezierPath * currentPath = [self.pathArray lastObject];
    [currentPath addLineToPoint:movePoint];
    
    //调用drawRect划线
    [self setNeedsDisplay];
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取手指对应的触碰点
    UITouch * moveTouch = [touches anyObject];
    CGPoint movePoint = [moveTouch locationInView:self];
    
    //取出当前的路径，设置当前路径的终点
    UIBezierPath * currentPath = [self.pathArray lastObject];
    [currentPath addLineToPoint:movePoint];
    
    //调用drawRect划线
    [self setNeedsDisplay];
}


//画线
- (void)drawRect:(CGRect)rect
{
    //[[UIColor redColor] set];
    
    
    //由路径数组绘制所有的线段
    for (NSInteger stepIndex=0; stepIndex<stepCount; stepIndex++)
    {
        UIBezierPath *path = self.pathArray[stepIndex];
        [path stroke];
    }
    
}


#pragma mark - 画图操作

- (void)save
{
    
    __typeof(self) __weak weakSelf =self;
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存到相册？" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView showAlertViewWithOKBlock:^(NSInteger buttonIndex) {
        if (buttonIndex != alertView.cancelButtonIndex)
        {
            // 1.创建bitmap上下文
            UIGraphicsBeginImageContext(weakSelf.frame.size);
            // 2.将要保存的view的layer绘制到bitmap上下文中
            [weakSelf.layer renderInContext:UIGraphicsGetCurrentContext()];
            // 3.取出绘制号的图片
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            // 4.保存到相册
            UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [self showMessageWithString:@"保存失败！！！"];
    }
    else
    {
        [self showMessageWithString:@"保存成功..."];
    }
}

- (void)undo
{
    if (stepCount == 1)
    {
        stepCount -= 1;
        self.topView.undoBtn.enabled = NO;
    }
    else
    {
        stepCount -= 1;
        self.topView.redoBtn.enabled = YES;
    }
    //stepCount = stepCount==0?0:stepCount-1;
    [self setNeedsDisplay];
}

- (void)redo
{
    if (stepCount>=self.pathArray.count-1)
    {
        stepCount += 1;
        self.topView.redoBtn.enabled = NO;
        self.topView.undoBtn.enabled = YES;
    }
    else
    {
        stepCount += 1;
        self.topView.redoBtn.enabled = YES;
        self.topView.undoBtn.enabled = YES;
    }
    //stepCount = stepCount>=self.touchPointArray.count?stepCount:stepCount+1;
    [self setNeedsDisplay];
}

- (void)clear
{
    self.topView.redoBtn.enabled = NO;
    self.topView.undoBtn.enabled = NO;
    
    stepCount = 0;
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}


#pragma mark - 提示视图

- (void)showMessageWithString:(NSString *)message
{
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 60)];
    messageLabel.layer.cornerRadius = 8;
    messageLabel.layer.masksToBounds = YES;
    messageLabel.center = self.center;
    messageLabel.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.text = message;
    messageLabel.alpha = 0.0;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:messageLabel];
    
    __unsafe_unretained UILabel * unsafeMessageLab = messageLabel;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        unsafeMessageLab.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            unsafeMessageLab.alpha = 0.0;
        } completion:^(BOOL finished) {
            [unsafeMessageLab removeFromSuperview];
        }];
        
    }];
    
    
}

@end
