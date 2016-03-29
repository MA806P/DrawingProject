//
//  YZDrawPaperView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/22.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawPaperView.h"
#import "YZDrawTopView.h"
#import "UIAlertView+ShowBlock.h"

@interface YZDrawPaperView ()

/** 保存手指在屏幕上滑动的点 */
@property (nonatomic, strong) NSMutableArray * touchPointArray;

/** 画板的顶部视图 */
@property (nonatomic, strong) YZDrawTopView * topView;

@end

static NSUInteger stepCount = 0;

@implementation YZDrawPaperView


- (NSMutableArray *)touchPointArray
{
    if (_touchPointArray == nil)
    {
        _touchPointArray = [NSMutableArray array];
    }
    return _touchPointArray;
}

+ (id)drawPaperViewWithTopView:(YZDrawTopView *)topView
{
    YZDrawPaperView * paperView = [[self alloc] init];
    paperView.topView = topView;
    return paperView;
}


#pragma mark - 视图触摸处理

//开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self endEditing:YES];
    //NSLog(@" touchesBegan ");
    
    NSUInteger touchPointArrayCount = self.touchPointArray.count;
    if(touchPointArrayCount>0 && touchPointArrayCount>stepCount)
    {
        [self.touchPointArray removeObjectsInRange:NSMakeRange(stepCount, touchPointArrayCount-stepCount)];
        self.topView.redoBtn.enabled = NO;
    }
    else
    {
        self.topView.undoBtn.enabled = YES;
    }
    
    
    
    UITouch * beganTouch = [touches anyObject];
    CGPoint beganPoint = [beganTouch locationInView:self];
    
    NSMutableArray * subTouchPointArray = [NSMutableArray array];
    [subTouchPointArray addObject:[NSValue valueWithCGPoint:beganPoint]];
    
    //大数组里面包含着小数组，小数组保存的手指滑动经过的点从开始到结束
    [self.touchPointArray addObject:subTouchPointArray];
}

//触摸滑动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@" touchesMoved ");
    UITouch * moveTouch = [touches anyObject];
    CGPoint movePoint = [moveTouch locationInView:self];
    
    NSMutableArray * subTouchPointArray = [self.touchPointArray lastObject];
    [subTouchPointArray addObject:[NSValue valueWithCGPoint:movePoint]];
    
    stepCount = self.touchPointArray.count;
    //调用drawRect划线
    [self setNeedsDisplay];
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@" touchesEnded ");
    
    UITouch * endTouch = [touches anyObject];
    CGPoint endPoint = [endTouch locationInView:self];
    
    NSMutableArray * subTouchPointArray = [self.touchPointArray lastObject];
    [subTouchPointArray addObject:[NSValue valueWithCGPoint:endPoint]];
    
    stepCount = self.touchPointArray.count;
    //调用drawRect划线
    [self setNeedsDisplay];
}


//画线，由点连成线
- (void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    for (NSInteger stepIndex=0; stepIndex<stepCount; stepIndex++)
    {
        NSMutableArray * subPoints = self.touchPointArray[stepIndex];
        for (int pointIndex=0; pointIndex<subPoints.count; pointIndex++)
        {
            CGPoint point = [subPoints[pointIndex] CGPointValue];
            if (pointIndex == 0)
            {
                //线段起点
                CGContextMoveToPoint(contextRef, point.x, point.y);
            }
            else
            {
                //线段终点
                CGContextAddLineToPoint(contextRef, point.x, point.y);
            }
        }
        
    }
    
    CGContextSetLineCap(contextRef, kCGLineCapRound); //线移动时的形状
    CGContextSetLineJoin(contextRef, kCGLineJoinRound); //线段转角处的形状
    CGContextSetLineWidth(contextRef, 2);
    
    //渲染
    CGContextStrokePath(contextRef);
    
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
    if (stepCount>=self.touchPointArray.count-1)
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
    [self.touchPointArray removeAllObjects];
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
