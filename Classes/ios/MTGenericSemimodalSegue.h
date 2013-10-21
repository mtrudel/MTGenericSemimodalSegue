//
//  MTGenericSemimodalSegue.h
//

#import <UIKit/UIKit.h>

#import "MTSemimodalHostingViewController.h"

@interface MTGenericSemimodalSegue : UIStoryboardSegue

- (void)performWithDuration:(CGFloat)duration animationBlock:(void(^)(MTSemimodalHostingViewController *host))animation unwindAnimationBlock:(void(^)(MTSemimodalHostingViewController *host))unwindAnimation;

- (CGSize)fullscreenSize;

@end
