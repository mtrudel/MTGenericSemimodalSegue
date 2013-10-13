//
//  MTGenericSemimodalSegue.m
//

#import "MTGenericSemimodalSegue.h"
#import "MTSemimodalHostingViewController.h"

@implementation MTGenericSemimodalSegue

- (void)performWithDuration:(CGFloat)duration animationBlock:(void(^)())animation unwindAnimationBlock:(void(^)())unwindAnimation {
  MTSemimodalHostingViewController *hostController = [[MTSemimodalHostingViewController alloc] init];
  hostController.unwindBlock = unwindAnimation;
  hostController.animationBlock = animation;
  hostController.duration = duration;
  [self.sourceViewController presentViewController:hostController animated:NO completion:^{
    [hostController presentViewController:self.destinationViewController];
  }];
}

@end
