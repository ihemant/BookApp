//
//  BookDetailViewController.m
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
@synthesize authorsLabel;
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize priceLabel;
@synthesize titleStr;
@synthesize authorStr;
@synthesize descriptionStr;
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
    self.titleLabel.text=self.titleStr; 
    self.authorsLabel.text=self.authorStr;
    self.descriptionLabel.text=self.descriptionStr;
    self.priceLabel.text=self.priceStr;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setAuthorsLabel:nil];
    [self setTitleLabel:nil];
    [self setDescriptionLabel:nil];
    [self setPriceLabel:nil];
    [self setPriceStr:nil];
    [self setDescriptionStr:nil];
    [self setTitleStr:nil];
    [self setAuthorStr:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [authorsLabel release];
    [titleLabel release];
    [descriptionLabel release];
    [priceLabel release];
    [priceStr release];
    [descriptionStr release];
    [authorStr release];
    [titleStr release];
    [super dealloc];
}
@end
