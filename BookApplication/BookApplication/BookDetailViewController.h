//
//  BookDetailViewController.h
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface BookDetailViewController : UIViewController
{
    NSString *titleStr;
    NSString *authorStr;
    NSString *descriptionStr;
    NSString *priceStr;


}
@property (retain, nonatomic) IBOutlet UILabel *authorsLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) NSString *titleStr;
@property (retain, nonatomic) NSString *authorStr;
@property (retain, nonatomic) NSString *descriptionStr;
@property (retain, nonatomic) NSString *priceStr;

@end
