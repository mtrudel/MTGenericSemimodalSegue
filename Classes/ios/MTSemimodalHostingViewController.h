//
//  MTSemimodalHostingViewController.h
//

#import <UIKit/UIKit.h>

@class MTSemimodalHostingViewController;

@protocol MTSemimodalViewControllerDelegate <NSObject>
@optional
- (void)semimodalViewControllerDidDismiss:(MTSemimodalHostingViewController *)semimodalController;
@end

@interface MTSemimodalHostingViewController : UIViewController
@property (nonatomic) NSUInteger supportedInterfaceOrientations;
@property (nonatomic, weak) id<MTSemimodalViewControllerDelegate> delegate;
@property (nonatomic, strong) void(^preAppearanceBlock)(MTSemimodalHostingViewController *host);
@property (nonatomic, strong) void(^animationBlock)(MTSemimodalHostingViewController *host);
@property (nonatomic, strong) void(^unwindBlock)(MTSemimodalHostingViewController *host);
@property (nonatomic) CGFloat duration;

/* 
 How much to darken the background view. Corresponds directly to the alpha value
 of a black masking view on top of the background. Defaults to 0 (no darkening). 
 Animatable.
 */
@property (nonatomic) CGFloat backgroundDarkeningFactor;

/*
 Should we disable rotation while presented. Defaults to NO
 */
@property (nonatomic) BOOL disableAutoRotation;

/*
 Should touches on the non-presented view result in a dismissal. Defaults to NO
 */
@property (nonatomic) BOOL dismissOnBackgroundTouch;

- (void)presentViewController:(UIViewController *)viewController;

@end
