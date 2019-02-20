//
//  ViewController.m
//  Ctrip打钩动画
//
//  Created by ww王伟(携程金融) on 2019/2/19.
//  Copyright © 2019 ww王伟(携程金融). All rights reserved.
//

#import "ViewController.h"
#import "CTCheckEffectView.h"

@interface ViewController ()

@property(nonatomic, strong) CTCheckEffectView *checkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 100, 100)];
    contentView.transform = CGAffineTransformMakeScale(0, 0);
    contentView.backgroundColor = [UIColor blueColor];
    contentView.clipsToBounds= YES;
    contentView.layer.cornerRadius = 50;
    [self.view addSubview:contentView];
    
    [UIView animateWithDuration:2 animations:^{
        contentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    
    self.checkView = [[CTCheckEffectView alloc] initWithFrame:CGRectMake(60, 100, 100, 100) themeColor:[UIColor blueColor]];
    [self.view addSubview:self.checkView];
    
    [self.checkView startAnimation];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.checkView stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.checkView startAnimation];
    });
}



@end
