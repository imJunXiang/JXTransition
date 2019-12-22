//
//  JXTransitionAnimation.m
//  HistoryList
//
//  Created by 王俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import "JXTransitionAnimation.h"
@interface JXTransitionAnimation()

@end

@implementation JXTransitionAnimation
#pragma mark - UIViewControllerAnimatedTransitioning
// 在这里处理具体的动画
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect finalRect = [transitionContext finalFrameForViewController:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]];
    toView.frame = CGRectOffset(finalRect, 0, finalRect.size.height);
    [transitionContext.containerView addSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

// 动画执行的时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
@end
