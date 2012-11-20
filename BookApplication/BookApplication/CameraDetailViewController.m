//
//  CameraDetailViewController.m
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraDetailViewController.h"

@interface CameraDetailViewController ()

@end

@implementation CameraDetailViewController
@synthesize priceLabel;
@synthesize makeLabel;
@synthesize modeLabel;
@synthesize modelStr;
@synthesize makeStr;
@synthesize priceStr;

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
    self.modeLabel.text=self.modelStr;
    self.makeLabel.text=self.makeStr;
    self.priceLabel.text=self.priceStr;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPriceLabel:nil];
    [self setMakeLabel:nil];
    [self setModeLabel:nil];
    [self setMakeStr:nil];
    [self setModelStr:nil];
    [self setPriceStr:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [priceLabel release];
    [makeLabel release];
    [modeLabel release];
    [modelStr release];
    [makeStr release];
    [priceStr release];
    
    [super dealloc];
}
@end
