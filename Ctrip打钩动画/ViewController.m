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
    
    self.checkView = [[CTCheckEffectView alloc] initWithFrame:CGRectMake(60, 100, 100, 100) themeColor:[UIColor blueColor]];
    [self.view addSubview:self.checkView];
    
    [self.checkView startAnimation];
}


@end
