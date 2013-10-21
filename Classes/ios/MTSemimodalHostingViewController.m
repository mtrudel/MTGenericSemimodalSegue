//
//  MTSemimodalHostingViewController.m
//

#import "MTSemimodalHostingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MTSemimodalHostingViewController ()
@property (nonatomic, weak) UIImageView *screenshotView;
@end

@implementation MTSemimodalHostingViewController

- (void)viewWillAppear:(BOOL)animated {
  [self setScreenshotBackground];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent {
  [self addChildViewController:viewControllerToPresent];
  [self.view addSubview:viewControllerToPresent.view];

  __weak typeof(viewControllerToPresent) weakViewController = viewControllerToPresent;
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:self.duration
                   animations:^{
                     self.animationBlock(self);
                   }
                   completion:^(BOOL finished) {
                     [weakViewController didMoveToParentViewController:weakSelf];
                   }];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
  __weak UIViewController *containedViewController = self.childViewControllers.lastObject;

  [containedViewController willMoveToParentViewController:nil];

  [UIView animateWithDuration:self.duration
                   animations:^{
                     self.unwindBlock(self);
                   }
                   completion:^(BOOL finished) {
    [containedViewController removeFromParentViewController];
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
  }];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self setScreenshotBackground];
}

- (void)setScreenshotBackground {
  UIView *oldScreenshot = self.screenshotView;
  self.screenshotView = [self screenshot];
  [self.view insertSubview:self.screenshotView atIndex:0];
  [oldScreenshot removeFromSuperview];
}

- (UIImageView *)screenshot {
  CGSize imageSize = CGSizeZero;

  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    imageSize = [UIScreen mainScreen].bounds.size;
  } else {
    imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
  }

  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, window.center.x, window.center.y);
    CGContextConcatCTM(context, window.transform);
    CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
      CGContextRotateCTM(context, M_PI_2);
      CGContextTranslateCTM(context, 0, -imageSize.width);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
      CGContextRotateCTM(context, -M_PI_2);
      CGContextTranslateCTM(context, -imageSize.height, 0);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
      CGContextRotateCTM(context, M_PI);
      CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    }
    [window.layer renderInContext:context];
    CGContextRestoreGState(context);
  }

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
  screenshot.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
  screenshot.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  return screenshot;
}

@end
