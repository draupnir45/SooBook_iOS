

#import <UIKit/UIKit.h>

@class RateView;

@protocol RateViewDelegate
- (void)rateView:(RateView *)rateView ratingDidChange:(CGFloat)rating;
@end

@interface RateView : UIView

@property (strong, nonatomic) UIImage *notSelectedImage;
@property (strong, nonatomic) UIImage *halfSelectedImage;
@property (strong, nonatomic) UIImage *fullSelectedImage;
@property (assign, nonatomic) CGFloat rating;
@property (assign) BOOL editable;
@property (strong) NSMutableArray * imageViews;
@property (assign, nonatomic) NSInteger maxRating;
@property (assign) NSInteger midMargin;
@property (assign) NSInteger leftMargin;
@property (assign) CGSize minImageSize;
@property (assign) id <RateViewDelegate> delegate;

@end
