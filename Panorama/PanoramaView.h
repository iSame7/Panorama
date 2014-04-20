//
//  PanoramaView.h
//  Panorama
//
//  Created by sameh mabrouk on 4/21/14.
//  Copyright (c) 2014 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanoramaView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL motionEnabled;
@property (nonatomic, assign) BOOL scrollIndicatorEnabled;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

@end
