//
//  ViewController.h
//  BookApplication
//
//  Created by iHemant on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCustomCell.h"
#import "CameraCustomCell.h"
#import "MusicCustomCell.h"
#import "CameraDetailViewController.h"
#import "MusicDetailViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "SQLiteOperation.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *bookArray;
    NSMutableArray *cameraArray;
    NSMutableArray *musicArray;
     MBProgressHUD *_hud;
    Reachability* internetReachable;
    Reachability* hostReachable;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic)NSMutableArray *bookArray;
@property (retain, nonatomic)NSMutableArray *cameraArray;
@property (retain, nonatomic) NSMutableArray *musicArray;
@property (retain) MBProgressHUD *hud;

- (void)fetchedData:(NSData *)responseData ;
- (void)dismissHUD:(id)arg ;
- (void)timeout:(id)arg ;

- (IBAction)showEmployeesFromSQLite:(id)sender ;
- (IBAction)save:(id)sender;
-(void)refreshBtnAction;

@end
