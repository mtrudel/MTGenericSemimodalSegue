//
//  MTSemimodalHostingViewController.h
//

#import <UIKit/UIKit.h>

@interface MTSemimodalHostingViewController : UIViewController
@property (nonatomic, strong) void(^animationBlock)();
@property (nonatomic, strong) void(^unwindBlock)();
@property (nonatomic) CGFloat duration;

- (void)presentViewController:(UIViewController *)viewController;

@end
