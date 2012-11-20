//
//  MusicDetailViewController.m
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicDetailViewController.h"

@interface MusicDetailViewController ()

@end

@implementation MusicDetailViewController
@synthesize titleLabel;
@synthesize albumLabel;
@synthesize artistLabel;
@synthesize genreLabel;
@synthesize titleStr;
@synthesize albumStr;
@synthesize artistStr;
@synthesize genreStr;

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
    self.albumLabel.text=self.albumStr;
    self.artistLabel.text=self.artistStr;
    self.titleLabel.text=self.titleStr;
    self.genreLabel.text=self.genreStr;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setAlbumLabel:nil];
    [self setArtistLabel:nil];
    [self setGenreLabel:nil];
    [self setTitleStr:nil];
    [self setAlbumStr:nil];
    [self setArtistStr:nil];
    [self setGenreStr:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [titleLabel release];
    [albumLabel release];
    [artistLabel release];
    [genreLabel release];
    [titleStr release];
    [albumStr release];
    [artistStr release];
    [genreStr release];
    [super dealloc];
}
@end
