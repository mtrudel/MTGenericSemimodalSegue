//
//  MTGenericSemimodalSegue.h
//

#import <UIKit/UIKit.h>

#import "MTSemimodalHostingViewController.h"

@interface MTGenericSemimodalSegue : UIStoryboardSegue

- (void)performWithDuration:(CGFloat)duration preAppearanceBlock:(void(^)(MTSemimodalHostingViewController *host))preAppearance animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation;

@end
