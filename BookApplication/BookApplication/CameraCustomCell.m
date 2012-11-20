//
//  ItemCustomCell.m
//
//
//  Created by iHemant on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraCustomCell.h"

@implementation CameraCustomCell
@synthesize pictureView;
@synthesize makeLabel;
@synthesize modelLabel;
@synthesize priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [pictureView release];
    [makeLabel release];
    [modelLabel release];
    [priceLabel release];

    [super dealloc];
}
@end
