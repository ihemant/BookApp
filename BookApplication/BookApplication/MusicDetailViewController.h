//
//  MusicDetailViewController.h
//  BookApplication
//
//  Created by iHemant on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicDetailViewController : UIViewController
{
    NSString *titleStr;
    NSString *albumStr;
    NSString *artistStr;
    NSString *genreStr;
}
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *albumLabel;
@property (retain, nonatomic) IBOutlet UILabel *artistLabel;
@property (retain, nonatomic) IBOutlet UILabel *genreLabel;

@property (retain, nonatomic) NSString *titleStr;
@property (retain, nonatomic) NSString *albumStr;
@property (retain, nonatomic) NSString *artistStr;
@property (retain, nonatomic) NSString *genreStr;


@end
