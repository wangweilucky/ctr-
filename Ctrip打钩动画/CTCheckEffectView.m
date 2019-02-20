//
//  CTCheckEffectView.m
//  Ctrip打钩动画
//
//  Created by ww王伟(携程金融) on 2019/2/19.
//  Copyright © 2019 ww王伟(携程金融). All rights reserved.
//

#import "CTCheckEffectView.h"

@interface CTCheckEffectView ()

/** themeColor */
@property(nonatomic, strong) UIColor *themeColor;

/** content cricle */
@property(nonatomic, strong) UIView *contentView;

/** ring */
@property(nonatomic, strong) CAShapeLayer *ringLayer;
/** animation cricle */
@property(nonatomic, strong) UIView *cricleView;
/** 勾选Layer */
@property(nonatomic, strong) CAShapeLayer *checkLayer;
/** 移动遮罩layer */
@property(nonatomic, strong) CAShapeLayer *coverLayer;

/** ring width */
@property(nonatomic, assign) CGFloat ctRingWidth;
/** centerPoint */
@property(nonatomic, assign) CGPoint ctCenterPoint;
/** width */
@property(nonatomic, assign) CGFloat ctWidth;
/** height */
@property(nonatomic, assign) CGFloat ctHeight;

@end

@implementation CTCheckEffectView


- (instancetype)initWithFrame:(CGRect)frame themeColor:(UIColor *)themeColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化参数
        self.themeColor = themeColor;
        self.ctRingWidth = 5;
        self.ctCenterPoint = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        self.ctWidth  = frame.size.width;
        self.ctHeight = frame.size.height;
        
    }
    return self;
}

- (void)initAllLayer {
    
    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.clipsToBounds= YES;
    contentView.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.contentView = contentView;
    [self addSubview:contentView];
    
    
    
    // 初始化cricle
//    CAShapeLayer *cricleLayer = [[CAShapeLayer alloc] init];
//    cricleLayer.frame = CGRectMake(0, 0, self.ctWidth, self.ctHeight);
////    cricleLayer.
//    self.cricleLayer = cricleLayer;
//    [contentView.layer addSublayer:cricleLayer];
//    cricleLayer.fillColor = self.themeColor.CGColor;
//    UIBezierPath *criclePath = [UIBezierPath bezierPathWithArcCenter:self.ctCenterPoint radius:self.ctWidth startAngle:0 endAngle:2*M_PI clockwise:NO];
//    cricleLayer.path = criclePath.CGPath;
//    CAAnimationGroup *cricleLayerAnimation = [self getCricleAnimation];
//    [cricleLayer addAnimation:cricleLayerAnimation forKey:@"cricleLayerAnimation"];
//
//
//    cricleLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    
    UIView *cricleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.ctWidth, self.ctHeight)];
    cricleView.center = self.ctCenterPoint;
    cricleView.transform = CGAffineTransformMakeScale(0, 0);
    cricleView.backgroundColor = self.themeColor;
//    cricleView.clipsToBounds= YES;
    cricleView.layer.cornerRadius = self.ctWidth * 0.5;
    self.cricleView = cricleView;
    [contentView addSubview:cricleView];
    
    [UIView animateWithDuration:2 animations:^{
        cricleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self showCheck];
    }];
    
    
    // 初始化ring
    CAShapeLayer *ringLayer = [[CAShapeLayer alloc] init];
    self.ringLayer = ringLayer;
    
    ringLayer.frame = CGRectMake(0, 0, self.ctWidth, self.ctHeight);
    ringLayer.fillColor = nil;
    ringLayer.strokeColor = self.themeColor.CGColor;
    ringLayer.lineWidth = self.ctRingWidth;
    ringLayer.backgroundColor = nil;
    UIBezierPath *ringPath = [UIBezierPath bezierPathWithArcCenter:self.ctCenterPoint radius:(self.ctWidth - self.ctRingWidth) startAngle:0 endAngle:2 * M_PI clockwise:NO];
    ringLayer.path = ringPath.CGPath;
    [contentView.layer addSublayer:ringLayer];
//    [UIView animateWithDuration:0.5 animations:^{
//        cricleView.transform = CGAffineTransformMakeScale(1, 1);
//    }completion:^(BOOL finished) {
//        [self showCheck];
//    }];
    
  
    
    
    
}


- (void)showCheck {
    // 初始化checkLayer
    CAShapeLayer *checkLayer = [[CAShapeLayer alloc] init];
    checkLayer.frame = CGRectMake(0, 0, self.ctWidth, self.ctHeight);
    
    UIBezierPath *checkLayerPath = [[UIBezierPath alloc] init];
    [checkLayerPath moveToPoint:CGPointMake(20, 35)];
    [checkLayerPath addLineToPoint:CGPointMake(35, 27)];
    [checkLayerPath addLineToPoint:CGPointMake(55, 40)];
    [checkLayerPath addLineToPoint:CGPointMake(100, 0)];
    [checkLayerPath addLineToPoint:CGPointMake(100, 20)];
    [checkLayerPath addLineToPoint:CGPointMake(55, 75)];
    
    checkLayer.path = checkLayerPath.CGPath;
    checkLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:checkLayer];
    
    // 蓝色的蒙层移动
    CAShapeLayer *coverLayer = [[CAShapeLayer alloc] init];
    coverLayer.frame = CGRectMake(10, 10, self.ctWidth, self.ctHeight);
    
    UIBezierPath *coverLayerPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    coverLayer.path = coverLayerPath.CGPath;
    coverLayer.fillColor = self.themeColor.CGColor;
    
    [self.contentView.layer addSublayer:coverLayer];
    
    coverLayer.shadowColor = [UIColor blueColor].CGColor;//shadowColor阴影颜色
    coverLayer.shadowOffset = CGSizeMake(-1, 1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    coverLayer.shadowOpacity = 1;//阴影透明度，默认0
    coverLayer.shadowRadius = 10;//阴影半径，默认3
    
    CABasicAnimation *coverAnimation = [self getCoverAnimation];
    [coverLayer addAnimation:coverAnimation forKey:@"getCoverAnimation"];
    
}

- (CAAnimationGroup *)getCricleAnimation {
    
    
    /*
     let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
     
     // Animation
     let animationA = CAKeyframeAnimation(keyPath: "transform.scale")
     animationA.keyTimes = [0, 0.3, 1]
     animationA.timingFunctions = [timingFunction, timingFunction]
     animationA.values = [1, 0.3, 1]
     
     let animationB = CAKeyframeAnimation(keyPath: "fillColor")
     animationB.keyTimes = [0, 0.3, 1]
     animationB.timingFunctions = [timingFunction, timingFunction]
     animationB.values = [UIColor.blue.cgColor, UIColor.red.cgColor, UIColor.yellow.cgColor]
     
     let animationGroup = CAAnimationGroup()
     animationGroup.animations = [animationA, animationB]
     animationGroup.duration = duration
     animationGroup.repeatCount = HUGE
     animationGroup.isRemovedOnCompletion = false
     */
    
    CABasicAnimation *opacityAnima = [[CABasicAnimation alloc] init];
    opacityAnima.keyPath = @"opacity";
    opacityAnima.fromValue = @0;
    opacityAnima.toValue = @1;
    
    CAMediaTimingFunction *timeFunc = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.68 :0.18 :1.08];
    CAKeyframeAnimation *scaleAnima = [[CAKeyframeAnimation alloc] init];
    scaleAnima.keyPath = @"transform.scale";
    scaleAnima.keyTimes = @[@0, @0.3, @1];
    scaleAnima.values = @[@0.1, @0.3, @1];
    scaleAnima.timingFunctions = @[timeFunc, timeFunc];
    
//    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnima.fromValue = [NSValue valueWithCATransform3D:(CATransform3DMakeScale(0, 0, 0))];
//    scaleAnima.toValue = [NSValue valueWithCATransform3D:(CATransform3DMakeScale(1, 1, 1))];

    
    CAAnimationGroup *g = [[CAAnimationGroup alloc] init];
    g.animations = @[opacityAnima, scaleAnima];
    g.repeatCount = 1;
    g.removedOnCompletion = NO;
    g.duration = 0.25;
    g.autoreverses = NO;
    return g;
}

- (CABasicAnimation *)getCoverAnimation {
    
    /* 移动 */
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.beginTime = CACurrentMediaTime()+ 2;
    // 动画选项的设定
    animation.duration = 0.5; // 持续时间
    animation.repeatCount = 1; // 重复次数
    
    // 起始帧和终了帧的设定
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(10, 0)]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 0)]; // 终了帧

    // 动画后不移动到初始位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (void)startAnimation {
    [self initAllLayer];
}

- (void)stopAnimation {
    [self.ringLayer removeFromSuperlayer];
    [self.checkLayer removeFromSuperlayer];
    [self.coverLayer removeFromSuperlayer];
    [self.contentView removeFromSuperview];
}



@end
