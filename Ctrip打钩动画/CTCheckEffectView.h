//
//  CTCheckEffectView.h
//  Ctrip打钩动画
//
//  Created by ww王伟(携程金融) on 2019/2/19.
//  Copyright © 2019 ww王伟(携程金融). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTCheckEffectView : UIView

/** 是否正在动画中 */
@property(nonatomic, assign) BOOL isAnimationing;

// 必须使用此方法来初始化
- (instancetype)initWithFrame:(CGRect)frame themeColor:(UIColor *)themeColor;

- (void)startAnimation;

- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
