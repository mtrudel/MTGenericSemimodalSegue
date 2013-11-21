//
//  MTGenericSemimodalSegue.m
//

#import "MTGenericSemimodalSegue.h"
#import "UIViewController+GenericSemimodal.h"

@implementation MTGenericSemimodalSegue

- (void)performWithDuration:(CGFloat)duration animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation {
  UIViewController *presentingController = self.sourceViewController;
  [presentingController presentViewController:self.destinationViewController withDuration:duration animationBlock:animation unwindAnimationBlock:unwindAnimation];
}

- (CGSize)fullscreenSize {
  CGSize size = [[UIScreen mainScreen] bounds].size;
  if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
    size = CGSizeMake(size.height, size.width);
  }
  return size;
}

@end
