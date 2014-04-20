//
//  UIScrollView+PanoramaIndicator.m
//  Panorama
//
//  Created by sameh mabrouk on 4/21/14.
//  Copyright (c) 2014 sam. All rights reserved.
//

#import "UIScrollView+PanoramaIndicator.h"
#import <objc/runtime.h>

static const char viewScrollIndicatorKey;
static const char backgroundViewScrollIndicatorKey;
static const CGFloat CRScrollIndicatorHeight = 1.0f;
static const CGFloat CRScrollIndicatorBottomSpace = 20.0f;
static const CGFloat CRScrollIndicatorDefaultWidth = 20.0f;
static const CGFloat CRScrollIndicatorLeftRightThreshold = 16.0f;


@implementation UIScrollView (PanoramaIndicator)
#pragma mark - Getters/Setters

- (void)setViewForPanoramaIndicator:(UIView *)viewScrollIndicator
{
    objc_setAssociatedObject(self, &viewScrollIndicatorKey, viewScrollIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getViewForPanoramaIndicator
{
    return objc_getAssociatedObject(self, &viewScrollIndicatorKey);
}

- (void)setBackgroundViewForPanoramaIndicator:(UIView *)backgroundViewScrollIndicator
{
    objc_setAssociatedObject(self, &backgroundViewScrollIndicatorKey, backgroundViewScrollIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getBackgroundViewForPanoramaIndicator
{
    return objc_getAssociatedObject(self, &backgroundViewScrollIndicatorKey);
}

#pragma mark - Class methods

- (void)enablePanoramaIndicator
{
    if (![self getBackgroundViewForPanoramaIndicator] && ![self getViewForPanoramaIndicator])
    {
        self.showsHorizontalScrollIndicator = NO;
        UIColor *indicatorColor = [UIColor whiteColor];
        
        // Configure the scroll indicator's background
        CGFloat backgroundIndicatorWidth = self.frame.size.width - (CRScrollIndicatorLeftRightThreshold * 2);
        CGRect backgroundIndicatorFrame = CGRectMake(self.contentOffset.x + (self.frame.size.width / 2) - (backgroundIndicatorWidth / 2), self.frame.size.height - CRScrollIndicatorHeight - CRScrollIndicatorBottomSpace, backgroundIndicatorWidth, CRScrollIndicatorHeight);
        UIView *backgroundViewScrollIndicator = [[UIView alloc] initWithFrame:backgroundIndicatorFrame];
        [backgroundViewScrollIndicator setBackgroundColor:[indicatorColor colorWithAlphaComponent:0.50]];
        [self setBackgroundViewForPanoramaIndicator:backgroundViewScrollIndicator];
        [self addSubview:backgroundViewScrollIndicator];
        
        // Configure the scroll indicator
        CGFloat viewScrollIndicatorWidth = (self.bounds.size.width - (CRScrollIndicatorLeftRightThreshold * 2)) * (self.bounds.size.width - (CRScrollIndicatorLeftRightThreshold * 2)) / self.contentSize.width;
        if (viewScrollIndicatorWidth < CRScrollIndicatorDefaultWidth) {
            viewScrollIndicatorWidth = CRScrollIndicatorDefaultWidth;
        }
        CGRect frame = CGRectMake(self.contentOffset.x + (self.frame.size.width / 2) - (viewScrollIndicatorWidth / 2), self.frame.size.height - CRScrollIndicatorHeight - CRScrollIndicatorBottomSpace, viewScrollIndicatorWidth, CRScrollIndicatorHeight);
        UIView *viewScrollIndicator = [[UIView alloc] initWithFrame:frame];
        [viewScrollIndicator setBackgroundColor:[indicatorColor colorWithAlphaComponent:1.0f]];
        [self setViewForPanoramaIndicator:viewScrollIndicator];
        [self addSubview:viewScrollIndicator];
        
        [self cr_setupObservers];
    }
}

- (void)refreshPanoramaIndicator
{
    [self refreshBackgroundPanormamIndicator];
    [self refreshPanoramaViewIndicator];
}

- (void)refreshBackgroundPanormamIndicator
{
    UIView *backgroundViewScrollIndicator = [self getBackgroundViewForPanoramaIndicator];
    CGRect rect =  backgroundViewScrollIndicator.frame;
    CGFloat x = self.contentOffset.x + CRScrollIndicatorLeftRightThreshold;
    rect.origin.x = x;
    backgroundViewScrollIndicator.frame = rect;
}

- (void)refreshPanoramaViewIndicator
{
    UIView *viewScrollIndicator = [self getViewForPanoramaIndicator];
    CGRect rect =  viewScrollIndicator.frame;
    CGFloat percent = self.contentOffset.x / self.contentSize.width;
    CGFloat x = self.contentOffset.x + ((self.bounds.size.width - CRScrollIndicatorLeftRightThreshold) * percent) + CRScrollIndicatorLeftRightThreshold;
    rect.origin.x = x;
    viewScrollIndicator.frame = rect;
}

- (void)disablePanoramaIndicator
{
    @try {
        [self cr_unsetObservers];
        
        [[self getBackgroundViewForPanoramaIndicator] removeFromSuperview];
        [[self getViewForPanoramaIndicator] removeFromSuperview];
        
        [self setBackgroundViewForPanoramaIndicator:nil];
        [self setViewForPanoramaIndicator:nil];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark - KVO

- (void)cr_setupObservers
{
    [self addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
}

- (void)cr_unsetObservers
{
    [self removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.contentSize.width > 0.0f) {
        [self refreshPanoramaIndicator];
    }
}

@end

