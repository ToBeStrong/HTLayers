//
//  ViewController.m
//  HTReplicatorLayer
//
//  Created by sunchunlei on 16/3/15.
//  Copyright (c) 2016年 sunchunlei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self animationMusic];
//    [self animationActivity];
      [self animationFollowLeader];
}

/**
 *  使用贝塞尔曲线
 */
- (void)animationFollowLeader{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                        radius:50
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:YES];
    
    CAReplicatorLayer *replayer = [[CAReplicatorLayer alloc] init];
    replayer.bounds = self.view.bounds;
    replayer.position = self.view.center;
    replayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75].CGColor;
    replayer.cornerRadius = 10;
    [self.view.layer addSublayer:replayer];
    
    // dot
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, 10, 10);
    dot.position = CGPointMake(100, 40);
    dot.borderWidth = 1;
    dot.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:1.0].CGColor;
    dot.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:0.8].CGColor;
    dot.cornerRadius = 5;
    /** shouldRasterize 
        rasterizationScale
     *  当shouldRasterize设成true时，layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。实现圆角本身就是在做颜色混合（blending），如果每次页面出来时都blending，消耗太大，这时shouldRasterize = yes，下次就只是简单的从渲染引擎的cache里读取那张bitmap，节约系统资源。
     */
    dot.shouldRasterize = true;
    dot.rasterizationScale = [UIScreen mainScreen].scale;
    [replayer addSublayer:dot];

    // animation
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.path = path.CGPath;
    move.repeatCount = INFINITY;
    move.duration = 4.0;
    [dot addAnimation:move forKey:nil];
    
    replayer.instanceCount = 50;
    replayer.instanceDelay = 0.1;
}

/**
 *  指示器
 */
- (void)animationActivity{

    CAReplicatorLayer *replayer = [[CAReplicatorLayer alloc] init];
    replayer.bounds = CGRectMake(0, 0, 200, 200);
    replayer.position = self.view.center;
    replayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75].CGColor;
    replayer.cornerRadius = 10;
    [self.view.layer addSublayer:replayer];
    
    // dot
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, 20, 20);
    dot.position = CGPointMake(100, 40);
    dot.borderWidth = 1;
    dot.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:1.0].CGColor;
    dot.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:0.8].CGColor;
    dot.cornerRadius = 10;
    
    dot.shouldRasterize = true;
    dot.rasterizationScale = [UIScreen mainScreen].scale;

    [replayer addSublayer:dot];
    
    //
    NSInteger num = 15;
    replayer.instanceCount = num;
    replayer.instanceTransform = CATransform3DMakeRotation((2*M_PI/num), 0, 0, 1.0);
    replayer.instanceColor = [UIColor redColor].CGColor;
    replayer.instanceAlphaOffset = -0.03;
    
    // animation
    CGFloat durition = 1.5;
    CABasicAnimation *shrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrink.fromValue = @(1.0);
    shrink.toValue = @(0.1);
    shrink.duration = durition;
    shrink.repeatCount = INFINITY;
    [dot addAnimation:shrink forKey:nil];
    replayer.instanceDelay = durition/num;
    
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}


/**
 *  音乐指示器
 */
- (void)animationMusic{

    // CAReplicatorLayer
    CAReplicatorLayer *repLayer = [[CAReplicatorLayer alloc] init];
    repLayer.bounds = CGRectMake(0, 0, 60, 60);
    repLayer.position = self.view.center;
    //    repLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:repLayer];
    
    
    // bar
    CALayer *bar = [CALayer layer];
    bar.bounds = CGRectMake(0, 0, 8, 40);
    bar.position = CGPointMake(10,75);
    bar.backgroundColor = [UIColor redColor].CGColor;
    bar.cornerRadius = 2;
    [repLayer addSublayer:bar];
    
    // bar-animation
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position.y"];
    move.toValue = [NSNumber numberWithDouble:(bar.position.y - 35.0)];
    move.repeatCount = INFINITY;
    move.autoreverses = YES;
    [bar addAnimation:move forKey:nil];
    
    // do-replicate
    repLayer.instanceCount = 3;
    repLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    repLayer.instanceDelay = 0.8;
    repLayer.masksToBounds = YES;
}


@end
