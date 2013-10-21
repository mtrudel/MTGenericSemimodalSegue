//
//  MTSemimodalHostingViewController.h
//

#import <UIKit/UIKit.h>

@interface MTSemimodalHostingViewController : UIViewController
@property (nonatomic, strong) void(^animationBlock)(MTSemimodalHostingViewController *host);
@property (nonatomic, strong) void(^unwindBlock)(MTSemimodalHostingViewController *host);
@property (nonatomic) CGFloat duration;

- (void)presentViewController:(UIViewController *)viewController;

@end
