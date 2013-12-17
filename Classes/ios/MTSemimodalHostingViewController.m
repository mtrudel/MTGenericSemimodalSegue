//
//  MTSemimodalHostingViewController.m
//

#import "MTSemimodalHostingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MTSemimodalHostingViewController ()
@property (nonatomic, strong) UIView *darkeningView;
@end

@implementation MTSemimodalHostingViewController

- (void)viewDidLoad {
  self.view.backgroundColor = [UIColor clearColor];
  // Add a subview so that we can do tap tracking without having to discriminate which view it landed in
  self.darkeningView = [[UIView alloc] initWithFrame:self.view.bounds];
  [self setBackgroundDarkeningFactor:[self backgroundDarkeningFactor]]; // Prime the initial alpha
  self.darkeningView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapInBackground:)];
  [self.darkeningView addGestureRecognizer:tapGestureRecognizer];
  [self.view addSubview:self.darkeningView];
}

- (BOOL)shouldAutorotate {
  return !self.disableAutoRotation;
}

- (void)setBackgroundDarkeningFactor:(CGFloat)backgroundDarkeningFactor {
  _backgroundDarkeningFactor = backgroundDarkeningFactor;
  self.darkeningView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:backgroundDarkeningFactor];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent {
  [self addChildViewController:viewControllerToPresent];
  [self.view addSubview:viewControllerToPresent.view];

  if (self.preAppearanceBlock) {
    self.preAppearanceBlock(self);
  }

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
                     if ([self.delegate respondsToSelector:@selector(semimodalViewControllerDidDismiss:)]) {
                       [self.delegate semimodalViewControllerDidDismiss:self];
                     }
  }];
}

- (void)didTapInBackground:(UITapGestureRecognizer *)gestureRecognizer {
  if (self.dismissOnBackgroundTouch) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

@end
