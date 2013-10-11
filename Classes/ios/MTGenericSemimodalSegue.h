//
//  MTGenericSemimodalSegue.h
//

#import <UIKit/UIKit.h>

@interface MTGenericSemimodalSegue : UIStoryboardSegue

- (void)performWithDuration:(CGFloat)duration animationBlock:(void(^)())animation unwindAnimationBlock:(void(^)())unwindAnimation;

@end
