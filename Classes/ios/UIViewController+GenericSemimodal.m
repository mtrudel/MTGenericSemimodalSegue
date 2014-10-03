//
//  UIViewController+GenericSemimodal.m
//  
//
//  Created by Mat Trudel on 11/21/2013.
//
//

#import "UIViewController+GenericSemimodal.h"

@implementation UIViewController (GenericSemimodal)

- (void)presentViewController:(UIViewController *)viewController withDuration:(CGFloat)duration preAppearanceBlock:(void(^)(MTSemimodalHostingViewController *host))preAppearance animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation {
  MTSemimodalHostingViewController *hostController = [[MTSemimodalHostingViewController alloc] init];
  hostController.unwindBlock = unwindAnimation;
  hostController.animationBlock = animation;
  hostController.preAppearanceBlock = preAppearance;
  hostController.duration = duration;
  hostController.supportedInterfaceOrientations = self.supportedInterfaceOrientations;
  hostController.delegate = (id<MTSemimodalViewControllerDelegate>)self;
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    hostController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  } else {
    [self viewControllerThatWillBePresenting].modalPresentationStyle = UIModalPresentationCurrentContext;
  }
  [self presentViewController:hostController animated:NO completion:^{
    [hostController presentViewController:viewController];
  }];
}

- (UIViewController *)viewControllerThatWillBePresenting {
  UIViewController *vc;
  for (vc = self; vc.parentViewController; vc = vc.parentViewController);
  return vc;
}

@end
