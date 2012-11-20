//
//  CameraDetailViewController.h
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraDetailViewController : UIViewController
{
    NSString *modelStr;
    NSString *makeStr;
    NSString *priceStr;
}

@property (retain, nonatomic) NSString *modelStr;
@property (retain, nonatomic) NSString *makeStr;
@property (retain, nonatomic) NSString *priceStr;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *makeLabel;
@property (retain, nonatomic) IBOutlet UILabel *modeLabel;

@end
