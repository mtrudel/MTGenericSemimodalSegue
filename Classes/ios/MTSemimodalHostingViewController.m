//
//  MTSemimodalHostingViewController.m
//

#import "MTSemimodalHostingViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MTSemimodalHostingViewController

- (void)viewWillAppear:(BOOL)animated {
  [self.view addSubview:[self screenshot]];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent {
  [self addChildViewController:viewControllerToPresent];
  [self.view addSubview:viewControllerToPresent.view];

  __weak typeof(viewControllerToPresent) weakViewController = viewControllerToPresent;
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:self.duration
                   animations:self.animationBlock
                   completion:^(BOOL finished) {
                     [weakViewController didMoveToParentViewController:weakSelf];
                   }];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
  __weak UIViewController *containedViewController = self.childViewControllers.lastObject;

  [containedViewController willMoveToParentViewController:nil];

  [UIView animateWithDuration:self.duration animations:self.unwindBlock completion:^(BOOL finished) {
    [containedViewController removeFromParentViewController];
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
  }];
}

- (UIImageView *)screenshot {
  CGSize imageSize = [[UIScreen mainScreen] bounds].size;
  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);

  CGContextRef context = UIGraphicsGetCurrentContext();

  // Iterate over every window from back to front
  for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
    if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
      // -renderInContext: renders in the coordinate space of the layer,
      // so we must first apply the layer's geometry to the graphics context
      CGContextSaveGState(context);
      // Center the context around the window's anchor point
      CGContextTranslateCTM(context, [window center].x, [window center].y);
      // Apply the window's transform about the anchor point
      CGContextConcatCTM(context, [window transform]);
      // Offset by the portion of the bounds left of and above the anchor point
      CGContextTranslateCTM(context,
                            -[window bounds].size.width * [[window layer] anchorPoint].x,
                            -[window bounds].size.height * [[window layer] anchorPoint].y);

      // Render the layer hierarchy to the current context
      [[window layer] renderInContext:context];

      // Restore the context
      CGContextRestoreGState(context);
    }
  }

  // Retrieve the screenshot image
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
  screenshot.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
  return screenshot;
}

@end
