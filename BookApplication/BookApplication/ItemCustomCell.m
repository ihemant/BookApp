//
//  ItemCustomCell.m
//
//
//  Created by iHemant on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemCustomCell.h"

@implementation ItemCustomCell
@synthesize titleLabel;
@synthesize  authorLabel;
@synthesize  priceLabel;
@synthesize  discriptionLabel;

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
    [titleLabel release];
    [authorLabel release];
    [priceLabel release];
    [discriptionLabel release];

    [super dealloc];
}
@end
