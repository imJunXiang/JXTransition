//
//  ViewController.m
//  JXTransitionExample
//
//  Created by 俊祥 on 2019/12/22.
//  Copyright © 2019 俊祥. All rights reserved.
//

#import "ViewController.h"
#import "JXTransition/UIViewController+JXTransition.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    NSLog(@"哈哈哈");
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickBtn:(UIButton *)btn {
    UIViewController *testVC = [[UIViewController alloc] initWithframe:CGRectMake(37.5, 300, 300, 300) transitionType:0];
    testVC.view.backgroundColor = [UIColor purpleColor];
    [self presentViewController:testVC animated:YES completion:nil];
}
@end
