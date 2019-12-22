//
//  UIViewController+JXTransition.h
//  HistoryList
//
//  Created by 俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JXTransition)
- (instancetype)initWithframe:(CGRect)frame transitionType:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
