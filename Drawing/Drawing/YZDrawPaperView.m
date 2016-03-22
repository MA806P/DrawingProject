//
//  YZDrawPaperView.m
//  Drawing
//
//  Created by 159CaiMini02 on 16/3/22.
//  Copyright © 2016年 159CaiMini. All rights reserved.
//

#import "YZDrawPaperView.h"

@interface YZDrawPaperView ()

@property (nonatomic, strong) NSMutableArray * touchPointArray;

@end

static NSInteger stepCount = 0;

@implementation YZDrawPaperView


- (NSMutableArray *)touchPointArray
{
    if (_touchPointArray == nil)
    {
        _touchPointArray = [NSMutableArray array];
    }
    return _touchPointArray;
}


#pragma mark - 视图触摸处理

//开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self endEditing:YES];
    //NSLog(@" touchesBegan ");
    
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
    NSLog(@"save");
}

- (void)undo
{
    stepCount = stepCount==0?0:stepCount-1;
    [self setNeedsDisplay];
}

- (void)redo
{
    stepCount = stepCount>=self.touchPointArray.count?stepCount:stepCount+1;
    [self setNeedsDisplay];
}

- (void)clear
{
    stepCount = 0;
    [self.touchPointArray removeAllObjects];
    [self setNeedsDisplay];
}



@end
