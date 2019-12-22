//
//  UIViewController+JXTransition.m
//  HistoryList
//
//  Created by 俊祥 on 2019/9/9.
//  Copyright © 2019 王俊祥. All rights reserved.
//

#import "UIViewController+JXTransition.h"
#import <objc/runtime.h>
#import "JXTransitionManager.h"
@interface UIViewController()
@property (nonatomic ,strong) JXTransitionManager *transManger;
@end

static char *transMangerKey = "transMangerKey";

@implementation UIViewController (JXTransition)
// 忽略编译器警告
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithframe:(CGRect)frame transitionType:(NSInteger)type {
    self = [super init];
    if (self) {
        self.transManger = [[JXTransitionManager alloc] initWithViewController:self viewframe:frame transitionType:type];
        self.view.frame = frame;
    }
    return self;
}

- (void)setTransManger:(JXTransitionManager *)transManger {
    objc_setAssociatedObject(self, transMangerKey, transManger, OBJC_ASSOCIATION_RETAIN);
}

- (JXTransitionManager *)transManger {
    return objc_getAssociatedObject(self, transMangerKey);
}

#pragma mark - hook because the frame change later
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(setView:) withMethod:@selector(jx_setView:)];
    });
}

- (void)jx_setView:(UIView *)view {
    [self jx_setView:view];
    if (!CGRectEqualToRect(self.transManger.viewframe, CGRectZero)) {
        view.frame = self.transManger.viewframe;
    }
}

+ (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(newMethod),
                                        method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}
@end
