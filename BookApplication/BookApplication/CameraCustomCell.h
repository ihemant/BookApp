//
//  ItemCustomCell.h
//
//  Created by iHemant on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraCustomCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *pictureView;
@property (retain, nonatomic) IBOutlet UILabel *makeLabel;
@property (retain, nonatomic) IBOutlet UILabel *modelLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;

@end
