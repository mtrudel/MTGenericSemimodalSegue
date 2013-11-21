//
//  UIViewController+GenericSemimodal.m
//  
//
//  Created by Mat Trudel on 11/21/2013.
//
//

#import "UIViewController+GenericSemimodal.h"

@implementation UIViewController (GenericSemimodal)

- (void)presentViewController:(UIViewController *)viewController withDuration:(CGFloat)duration animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation {
  MTSemimodalHostingViewController *hostController = [[MTSemimodalHostingViewController alloc] init];
  hostController.unwindBlock = unwindAnimation;
  hostController.animationBlock = animation;
  hostController.duration = duration;
  [self presentViewController:hostController animated:NO completion:^{
    [hostController presentViewController:viewController];
  }];
}

@end
