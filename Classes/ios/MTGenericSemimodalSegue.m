//
//  MTGenericSemimodalSegue.m
//

#import "MTGenericSemimodalSegue.h"
#import "UIViewController+GenericSemimodal.h"

@implementation MTGenericSemimodalSegue

- (void)performWithDuration:(CGFloat)duration preAppearanceBlock:(void(^)(MTSemimodalHostingViewController *host))preAppearance animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation {
  UIViewController *presentingController = self.sourceViewController;
  [presentingController presentViewController:self.destinationViewController withDuration:duration preAppearanceBlock:preAppearance animationBlock:animation unwindAnimationBlock:unwindAnimation];
}

@end
