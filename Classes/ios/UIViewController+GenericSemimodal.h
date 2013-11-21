//
//  UIViewController+GenericSemimodal.h
//  
//
//  Created by Mat Trudel on 11/21/2013.
//
//

#import <UIKit/UIKit.h>
#import "MTSemimodalHostingViewController.h"

@interface UIViewController (GenericSemimodal)

- (void)presentViewController:(UIViewController *)viewController withDuration:(CGFloat)duration preAppearanceBlock:(void(^)(MTSemimodalHostingViewController *host))preAppearance animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation;

@end
