//
//  PanoramaViewController.m
//  Panorama
//
//  Created by sameh mabrouk on 4/21/14.
//  Copyright (c) 2014 sam. All rights reserved.
//

#import "PanoramaViewController.h"
#import "PanoramaView.h"

@interface PanoramaViewController ()

@end

@implementation PanoramaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PanoramaView *motionView = [[PanoramaView alloc] initWithFrame:self.view.bounds];
    [motionView setImage:[UIImage imageNamed:@"sam"]];
    [self.view addSubview:motionView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.view.frame.size.height - 50, 210, 20)];
    [titleLabel setText:@"Panorama View...Photo Tilt"];
    [titleLabel setShadowOffset:CGSizeMake(0, 1.0f)];
    [titleLabel setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [motionView addSubview:titleLabel];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
