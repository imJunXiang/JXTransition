//
//  JXPresentationController.m
//  HistoryList
//
//  Created by 王俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import "JXPresentationController.h"

@interface JXPresentationController ()
/** 黑色半透明背景 */
@property (nonatomic ,strong) UIView   *dimmingView;
@end

@implementation JXPresentationController
- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.opaque = NO;   // 设置不透明
        // 设置停靠模式
        _dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 增加手势事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
        [_dimmingView addGestureRecognizer:tap];
    }
    return _dimmingView;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 自定义动画效果的情况下，苹果强烈建议设置为UIModalPresentationCustom
        //        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
}

// 呈现过渡即将开始的时候被调用
// 可以在此方法创建和设置自定义动画所需的view
- (void)presentationTransitionWillBegin {
    [self.containerView addSubview:self.dimmingView];
    
    
    // 获取presentingViewController 的转换协调器，应该动画期间的一个类？上下文？之类的，负责动画的一个东西
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    // 动画期间，背景View的动画方式
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.4f;
    } completion:nil];
}

#pragma mark 点击了背景遮罩view
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// 在呈现过渡结束是被调用 并提供一个值判断是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed {
    // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
    if (!completed) {
        self.dimmingView = nil;
    }
}

// 消失过渡即将开始的时候被调用
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:nil];
}

// 消失过渡完成之后调用， 此时应该将试图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed == YES) {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}

// 返回目标控制器Viewframe
- (CGRect)frameOfPresentedViewInContainerView {
    if (!CGRectEqualToRect(self.toViewframe, CGRectZero)) {
        // 不为空 则返回新尺寸
        return self.toViewframe;
    }
    
    return self.containerView.bounds;
}

//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) [self.containerView setNeedsLayout];
}
@end
