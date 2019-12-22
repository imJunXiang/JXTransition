//
//  JXTransitionManager.h
//  HistoryList
//
//  Created by 俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 转场动画管理 传入vc和转场类型 */
@interface JXTransitionManager : NSObject
@property (nonatomic ,assign) CGRect          viewframe;
- (instancetype)initWithViewController:(UIViewController *)viewController viewframe:(CGRect)viewframe transitionType:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
