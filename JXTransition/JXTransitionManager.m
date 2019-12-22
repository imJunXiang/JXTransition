//
//  JXTransitionManager.m
//  HistoryList
//
//  Created by 俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import "JXTransitionManager.h"
#import "JXPresentationController.h"
#import "JXTransitionAnimation.h"

@interface JXTransitionManager ()<UIViewControllerTransitioningDelegate>
@property (nonatomic ,weak) UIViewController *controlVC;
@property (nonatomic ,assign) NSInteger      transitionType;
@end

@implementation JXTransitionManager
- (instancetype)initWithViewController:(UIViewController *)viewController viewframe:(CGRect)viewframe transitionType:(NSInteger)type {
    self = [super init];
    if (self) {
        // type 为标识 暂时用 NSInteger 后期会改为枚举
        self.controlVC = viewController;
        self.transitionType = type;
        self.viewframe = viewframe;
        [self setTransitionDelegateWithViewController:viewController transitionType:type];
    }
    return self;
}

#pragma mark - 设置代理
- (void)setTransitionDelegateWithViewController:(UIViewController *)viewController transitionType:(NSInteger)type {
    switch (type) {
        case 0: {
            // 模态
            [self setModalTransitionDelegateWithViewController:viewController];
        }   break;
        case 1: {
            
        }   break;
        case 2: {
            
        }   break;
        default: {
            
        }   break;
    }
}

// 设置模态 转场
- (void)setModalTransitionDelegateWithViewController:(UIViewController *)viewController {
    viewController.transitioningDelegate = self;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
}

#pragma mark - UIViewControllerTransitioningDelegate
/*
 presented为要弹出的Controller
 presenting为当前的Controller
 source为源Contrller 对于present动作  presenting与source是一样的
 */

// 模态视图的转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [JXTransitionAnimation new];
}

// 告诉控制器 谁是动画主管,负责转场动画(UIPresentationController)
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    JXPresentationController *presentC = [[JXPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentC.toViewframe = self.viewframe;
    return presentC;
}

@end
