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


/** ring */
@property(nonatomic, strong) CAShapeLayer *ringLayer;
/** animation cricle */
@property(nonatomic, strong) CAShapeLayer *cricleLayer;
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
        self.ctWidth  = frame.size.width * 0.5;
        self.ctHeight = frame.size.height * 0.5;
        
    }
    return self;
}

- (void)initAllLayer {
    // 初始化ring
    CAShapeLayer *ringLayer = [[CAShapeLayer alloc] init];
    self.ringLayer = ringLayer;
    [self.layer addSublayer:ringLayer];
    ringLayer.frame = CGRectMake(0, 0, self.ctWidth, self.ctHeight);
    ringLayer.fillColor = nil;
    ringLayer.strokeColor = self.themeColor.CGColor;
    ringLayer.lineWidth = self.ctRingWidth;
    ringLayer.backgroundColor = nil;
    UIBezierPath *ringPath = [UIBezierPath bezierPathWithArcCenter:self.ctCenterPoint radius:(self.ctWidth - self.ctRingWidth) startAngle:0 endAngle:2 * M_PI clockwise:NO];
    ringLayer.path = ringPath.CGPath;
    
    // 初始化cricle
    CAShapeLayer *cricleLayer = [[CAShapeLayer alloc] init];
    self.cricleLayer = cricleLayer;
    [self.layer addSublayer:cricleLayer];
    cricleLayer.anchorPoint = CGPointMake(.5, .5);
    cricleLayer.fillColor = self.themeColor.CGColor;
    UIBezierPath *criclePath = [UIBezierPath bezierPathWithArcCenter:self.ctCenterPoint radius:self.ctWidth  startAngle:0 endAngle:2 * M_PI clockwise:NO];
    cricleLayer.path = criclePath.CGPath;
    CAAnimationGroup *cricleLayerAnimation = [self getCricleAnimation];
    [cricleLayer addAnimation:cricleLayerAnimation forKey:@"cricleLayerAnimation"];
    
    // 初始化checkLayer
}

- (CAAnimationGroup *)getCricleAnimation {
    
    CABasicAnimation *opacityAnima = [[CABasicAnimation alloc] init];
    opacityAnima.keyPath = @"opacity";
    opacityAnima.fromValue = @0;
    opacityAnima.toValue = @1;
    
    CABasicAnimation *scaleAnima = [[CABasicAnimation alloc] init];
    scaleAnima.keyPath = @"transform.scale";
    scaleAnima.fromValue = @0.1;
    scaleAnima.toValue = @1;
    
    CAAnimationGroup *g = [[CAAnimationGroup alloc] init];
    g.animations = @[scaleAnima];
    g.repeatCount = 1;
    g.removedOnCompletion = NO;
    g.duration = 1.1;
    g.autoreverses = NO;
    return g;
}

- (void)startAnimation {
    [self initAllLayer];
}

- (void)stopAnimation {
    [self.ringLayer removeFromSuperlayer];
    [self.cricleLayer removeFromSuperlayer];
    [self.checkLayer removeFromSuperlayer];
    [self.coverLayer removeFromSuperlayer];
}


- (CAShapeLayer *)cricleLayer {
    if (!_cricleLayer) {
        _cricleLayer = [[CAShapeLayer alloc] init];
    }
    return _cricleLayer;
}

- (CAShapeLayer *)checkLayer {
    if (!_checkLayer) {
        _checkLayer = [[CAShapeLayer alloc] init];
    }
    return _checkLayer;
}

- (CAShapeLayer *)coverLayer {
    if (!_coverLayer) {
        _coverLayer = [[CAShapeLayer alloc] init];
    }
    return _coverLayer;
}

@end
