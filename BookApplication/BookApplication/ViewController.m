//
//  ViewController.m
//  BookApplication
//
//  Created by iHemant on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "BookDetailViewController.h"


@interface ViewController ()

@end

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 550.0f
#define CELL_CONTENT_MARGIN 12.0f


@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}
@end


@implementation ViewController
@synthesize tableView;
@synthesize bookArray;
@synthesize cameraArray;
@synthesize musicArray;
@synthesize hud=_hud;


- (void)viewDidLoad {
      [super viewDidLoad];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
    _hud.labelText = @"Loading...";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)] autorelease];
    
     self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshBtnAction)] autorelease];
    
   
    // check for internet connection
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
//    
//   // internetReachable = [[Reachability reachabilityForInternetConnection] retain];
//   // [internetReachable startNotifier];
//    
//    // check if a pathway to a random host exists
//    hostReachable = [[Reachability reachabilityWithHostName: @"http://www.google.com"] retain];
//    NSLog(@"hostReachable---->%@",hostReachable);
//    [hostReachable startNotifier];
    
    // allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // set the blocks 
    reach.reachableBlock = ^(Reachability*reach)
    {
        NSLog(@"REACHABLE!");
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
        _hud.labelText = @"Loading...";
        NSLog(@"UNREACHABLE!");
    };
    
    // start the notifier which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    
    self.bookArray         = [[NSMutableArray alloc] init];
    self.cameraArray         = [[NSMutableArray alloc] init];
    self.musicArray       = [[NSMutableArray alloc] init];
   
    NSString *completeURLStr = [NSString stringWithFormat:@"http://www.kaverisoft.com/careers/assignments/iphone/a1.php"];
    NSLog(@"complete--->%@",completeURLStr);
    
    dispatch_async(kBgQueue, ^{
        
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:completeURLStr]];
                [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
//        
    });
    NSLog(@"self.bookArray ----->%@",self.bookArray);
  

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    _hud=nil;
    [self setMusicArray:nil];
    [self setCameraArray:nil];
    [self setBookArray:nil];
    [self setTableView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
- (void)dealloc {
    [musicArray release];
    [cameraArray release];
    [bookArray release];
    [tableView release];
    [_hud release];    
    [super dealloc];
}


#pragma mark - 
#pragma mark - Table view data source
#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
       return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (section == 0) 
    {
        if([self.bookArray count]>0)
        return [self.bookArray count];
    }
    if (section == 1) 
    {
        if([self.cameraArray count]>0)
            return [self.cameraArray count]; 
    }
    if (section == 2)  
    {
        if([self.musicArray count]>0)
            return [self.musicArray count];  
        
        
    }
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(([self.bookArray count]!=0)||([self.cameraArray count]!=0)||([self.musicArray count]!=0))
    {
    if (section == 0) 
    {
        return @"Book";
    }
    if (section == 1) 
    {
        return @"Camera";
    }
     if (section == 2)  
    {
        return @"Music";

    }
    }
    return @"";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) 
    {
        if (indexPath.section==0) 
        {
            // return 120;-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
            
//                            
//                 NSString *text = [[self.bookArray objectAtIndex:indexPath.row] valueForKey:@"description"];
//                 CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 30000.0f);
//                 CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//                 
//                 CGFloat height = MAX(size.height, 44.0f);
//                 NSLog(@"height--->%lf",height + (CELL_CONTENT_MARGIN * 2));
//                 return height + (CELL_CONTENT_MARGIN * 2);
//                 //return 68;
              
            return 120;
            
            
        }
        if (indexPath.section==1) 
        {
            return 120;
        }
        if (indexPath.section==2) 
        {
            return 80;
        }
        
    }
    return 0.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Genric Table View Cell.....
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    int rowIs = indexPath.row;
    int secIs = indexPath.section;
    NSLog(@"secIs----->%d",secIs);
    
   static NSString *simpleTableIdentifier = @"ItemCustomCell";
   ItemCustomCell *cell1 = (ItemCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   if (cell1 == nil) {
       
       NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCustomCell" owner:self options:nil];
       cell1 = [nib objectAtIndex:0];
       
       }
    
    
    static NSString *simpleTableIdentifier1 = @"CameraCustomCell";
    CameraCustomCell *cell2 = (CameraCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
    if (cell2 == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CameraCustomCell" owner:self options:nil];
        cell2 = [nib objectAtIndex:0];
        
    }

    static NSString *simpleTableIdentifier3 = @"MusicCustomCell";
    MusicCustomCell *cell3 = (MusicCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier3];
    if (cell3 == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicCustomCell" owner:self options:nil];
        cell3 = [nib objectAtIndex:0];
        
    }

    if (secIs==0) 
    {
        
      //  BookDatabase *employee = [[self.bookArray objectAtIndex:indexPath.row] titleStr];
        
            if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"]!=nil)
            {
                    cell1.titleLabel.text = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"];
                //cell.textLabel.text = employee.name;
              //  employee.titleStr=[[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"];
            }
                else
                    cell1.titleLabel.text =@"";  
        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"authors"]!=nil)
            cell1.authorLabel.text = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"authors"];
        else
            cell1.authorLabel.text =@"";  
        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"price"]!=nil)
            cell1.priceLabel.text =[NSString stringWithFormat:@"%@", [[self.bookArray objectAtIndex:rowIs] valueForKey:@"price"]];
        else
            cell1.priceLabel.text =@"";  
        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"description"]!=nil)
        {
//            CGRect currentFrame = cell1.discriptionLabel.frame;
//            CGSize max = CGSizeMake(cell1.discriptionLabel.frame.size.width, 500);
//            CGSize expected = [[[self.bookArray objectAtIndex:rowIs] valueForKey:@"description"] sizeWithFont:cell1.discriptionLabel.font constrainedToSize:max lineBreakMode:cell1.discriptionLabel.lineBreakMode]; 
//            currentFrame.size.height = expected.height;
//            cell1.discriptionLabel.frame = currentFrame;
            
            cell1.discriptionLabel.text = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"description"];
        }
        else
            cell1.discriptionLabel.text =@"";  
                
                                return cell1;
            }
    
    
    if (secIs==1) 
    {
        
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"make"]!=nil)
            cell2.makeLabel.text = [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"make"];
        else
            cell2.makeLabel.text =@"";  
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"model"]!=nil)
            cell2.modelLabel.text = [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"model"];
        else
            cell2.modelLabel.text =@"";  
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"price"]!=nil)
            cell2.priceLabel.text =[NSString stringWithFormat:@"%@", [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"price"]];
        else
            cell2.priceLabel.text =@"";  
//        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"picture"]!=nil)
        {
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[[self.cameraArray objectAtIndex:rowIs] valueForKey:@"picture"]]];
            cell2.pictureView.image  = [UIImage imageWithData: imageData];
            [imageData release];
            
                    
        }
        else
            cell2.pictureView.image  =nil;  
        
        return cell2;
    }

    if (secIs==2) 
    {
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"title"]!=nil)
            cell3.titleLabel.text = [[self.musicArray objectAtIndex:rowIs] valueForKey:@"title"];
        else
            cell3.titleLabel.text =@"";  
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"album"]!=nil)
            cell3.albumLabel.text = [[self.musicArray objectAtIndex:rowIs] valueForKey:@"album"];
        else
            cell3.albumLabel.text =@"";  
        
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"artist"]!=nil)
            cell3.artistLabel.text = [[self.musicArray objectAtIndex:rowIs] valueForKey:@"artist"];
        else
            cell3.artistLabel.text =@"";  
        
        return cell3;
    }
    

        
         return cell;
   
}


#pragma mark - 
#pragma mark - Table view delegate
#pragma mark - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"index----------->%d  indexPath.section--->%d",indexPath.row,indexPath.section);
	//Get the selected country
	
    int rowIs = indexPath.row;
    int secIs = indexPath.section;
    
    AppDelegate *delegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (secIs==0) 
    {
        
        
        BookDetailViewController *dvController = [[BookDetailViewController alloc] initWithNibName:@"BookDetailViewController" bundle:[NSBundle mainBundle]];    
        NSLog(@"titlelabel------------->%@",[[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"]);
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"]!=nil)
           dvController.titleStr = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"title"];
        else
             dvController.titleStr =@"";  

        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"authors"]!=nil)
            dvController.authorStr = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"authors"];
        else
             dvController.authorStr =@"";  
        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"price"]!=nil)
             dvController.priceStr =[NSString stringWithFormat:@"%@", [[self.bookArray objectAtIndex:rowIs] valueForKey:@"price"]];
        else
            dvController.priceStr =@"";  
        
        if([[self.bookArray objectAtIndex:rowIs] valueForKey:@"description"]!=nil)
            dvController.descriptionStr = [[self.bookArray objectAtIndex:rowIs] valueForKey:@"description"];
        else
            dvController.descriptionStr =@"";  
        
        [delegate.navController pushViewController:dvController animated:YES];
    }
    
    
    
    if (secIs==1) 
    {
        
        
        CameraDetailViewController *cameraController = [[CameraDetailViewController alloc] initWithNibName:@"CameraDetailViewController" bundle:[NSBundle mainBundle]]; 
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"make"]!=nil)
            cameraController.makeStr  = [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"make"];
        else
            cameraController.makeStr =@"";  
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"model"]!=nil)
             cameraController.modelStr= [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"model"];
        else
            cameraController.modelStr =@"";  
        
        if([[self.cameraArray objectAtIndex:rowIs] valueForKey:@"price"]!=nil)
             cameraController.priceStr =[NSString stringWithFormat:@"%@", [[self.cameraArray objectAtIndex:rowIs] valueForKey:@"price"]];
        else
             cameraController.priceStr =@"";          
        [delegate.navController pushViewController:cameraController animated:YES];
    }
    if (secIs==2) 
    {
        
        
        MusicDetailViewController *musicController = [[MusicDetailViewController alloc] initWithNibName:@"MusicDetailViewController" bundle:[NSBundle mainBundle]]; 
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"title"]!=nil)
            musicController.titleStr= [[self.musicArray objectAtIndex:rowIs] valueForKey:@"title"];
        else
            musicController.titleStr =@"";  
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"album"]!=nil)
            musicController.albumStr= [[self.musicArray objectAtIndex:rowIs] valueForKey:@"album"];
        else
            musicController.albumStr =@"";  
        
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"artist"]!=nil)
            musicController.artistStr = [[self.musicArray objectAtIndex:rowIs] valueForKey:@"artist"];
        else
            musicController.artistStr =@"";  
        
        if([[self.musicArray objectAtIndex:rowIs] valueForKey:@"genre"]!=nil)
            musicController.genreStr = [[self.musicArray objectAtIndex:rowIs] valueForKey:@"genre"];
        else
            musicController.genreStr =@""; 
        
        [delegate.navController pushViewController:musicController animated:YES];
    }
    

    
	
	//Initialize the detail view controller and display it.
	
}



- (void)fetchedData:(NSData *)responseData 
{
   // NSLog(@"Inthe fetchData----->%@",responseData);
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                         options:kNilOptions 
                                                           error:&error];
    
  //  NSLog(@"Json---->%@  json count--->%d",json,[json count]);
    for(int i=0;i<[json count];i++){
        
        if ([(NSArray *)[json objectAtIndex:i]valueForKey:@"camera"] !=nil) {
            
            NSLog(@"Camera--->%@",[(NSArray *)[json objectAtIndex:i]valueForKey:@"camera"]);
            [self.cameraArray addObject:[(NSArray *)[json objectAtIndex:i]valueForKey:@"camera"]];

        }
        
        if ([(NSArray *)[json objectAtIndex:i]valueForKey:@"book"] !=nil) {
            
            NSLog(@"Book--->%@",[(NSArray *)[json objectAtIndex:i]valueForKey:@"book"]);
            [self.bookArray addObject:[(NSArray *)[json objectAtIndex:i]valueForKey:@"book"]];

        }
        
        if ([(NSArray *)[json objectAtIndex:i]valueForKey:@"music"] !=nil) {
            
            NSLog(@"Music-->\n%@",[(NSArray *)[json objectAtIndex:i]valueForKey:@"music"]);
            [self.musicArray addObject:[(NSArray *)[json objectAtIndex:i]valueForKey:@"music"]];

            
        }

        
    }
    if(responseData!=nil)
    {
        [self.tableView reloadData];
    _hud.labelText = @"Completed";
    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert.png"]] autorelease];
    _hud.mode = MBProgressHUDModeCustomView;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    }
    NSLog(@"[self.bookArray objectAtIndex:0]--->%@",[[self.bookArray objectAtIndex:0] valueForKey:@"authors"]);        
    
}


#pragma mark -
#pragma mark HUD Related Method
#pragma mark -


- (void)dismissHUD:(id)arg 
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
    
}

- (void)timeout:(id)arg 
{
    
    _hud.labelText = @"Timeout!";
    _hud.detailsLabelText = @"Please try again later.";
    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    _hud.mode = MBProgressHUDModeCustomView;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
//        Reachability *reach = [Reachability reachabilityForInternetConnection]; 
//        NetworkStatus netStatus = [reach currentReachabilityStatus]; 
//        if (netStatus == NotReachable) {  
//            NSLog(@"No internet connection!");  
//           } else {  
//    
//                self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//               [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
//               _hud.labelText = @"Loading...";
//               
//
//     }
//    
    [super viewWillAppear:animated];
}


-(void) checkNetworkStatus:(NSNotification *)notice {
   
   // called after network status changes
   NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
   BOOL internetActive;
   switch (internetStatus)
   {
           case NotReachable:
           {
               NSLog(@"The internet is down.");
               internetActive = NO;
               
               break;
               }
           case ReachableViaWiFi:
           {
               NSLog(@"The internet is working via WIFI.");
               internetActive = YES;
               
               break;
               }
           case ReachableViaWWAN:
           {
               NSLog(@"The internet is working via WWAN.");
               internetActive = YES;
               
               break;
               }
       }
   
   NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
   BOOL hostActive;
   switch (hostStatus)
   {
           case NotReachable:
           {
               NSLog(@"A gateway to the host server is down.");
               hostActive = NO;
               
               break;
               }
           case ReachableViaWiFi:
           {
               NSLog(@"A gateway to the host server is working via WIFI.");
               hostActive = YES;
               
               break;
               }
           case ReachableViaWWAN:
           {
               NSLog(@"A gateway to the host server is working via WWAN.");
               hostActive = YES;
               
               break;
               }
       }
}



- (IBAction)save:(id)sender 
{
    // Save the list to the SQLite database
    [[SQLiteOperation shared] cleanAllDataFromBook];
    [[SQLiteOperation shared] cleanAllDataFromMusic];
    [[SQLiteOperation shared] cleanAllDataFromCamera];


 
    NSLog(@"bookArray--------->%@",bookArray);
    
    for (int index = 0; index<[self.bookArray count]; index ++) {
        
        BookDatabase *bookInfo = [[BookDatabase alloc]init ];
        
         bookInfo.title = [[self.bookArray objectAtIndex:index]valueForKey:@"title"];
         bookInfo.authors = [[self.bookArray objectAtIndex:index]valueForKey:@"authors"];
         bookInfo.description = [[self.bookArray objectAtIndex:index]valueForKey:@"description"];
         bookInfo.price = [NSString stringWithFormat:@"%@", [[self.bookArray objectAtIndex:index] valueForKey:@"price"]];
        
        [[SQLiteOperation shared] addEmployee:bookInfo];
        [bookInfo release];
        
    }
    
    for (int index = 0; index<[self.cameraArray count]; index ++) {
        
        CameraDatabase *cameraInfo = [[CameraDatabase alloc]init ];
        
        cameraInfo.make = [[self.cameraArray objectAtIndex:index]valueForKey:@"make"];
        cameraInfo.model = [[self.cameraArray objectAtIndex:index]valueForKey:@"model"];
        cameraInfo.picture = [[self.cameraArray objectAtIndex:index]valueForKey:@"picture"];
        cameraInfo.price = [NSString stringWithFormat:@"%@", [[self.cameraArray objectAtIndex:index] valueForKey:@"price"]];
        
        [[SQLiteOperation shared] addCamera:cameraInfo];
        [cameraInfo release];
        
    }
    
    for (int index = 0; index<[self.musicArray count]; index ++) {
        
        musicDatabase *musicInfo = [[musicDatabase alloc]init ];
        
        musicInfo.album = [[self.musicArray objectAtIndex:index]valueForKey:@"album"];
        musicInfo.artist = [[self.musicArray objectAtIndex:index]valueForKey:@"artist"];
        musicInfo.genre = [[self.musicArray objectAtIndex:index]valueForKey:@"genre"];
        musicInfo.title = [[self.musicArray objectAtIndex:index] valueForKey:@"title"];
        
        [[SQLiteOperation shared] addMusic:musicInfo];
        [musicInfo release];
        
    }

    [self showEmployeesFromSQLite:sender];
    
    
   
}


- (IBAction)showEmployeesFromSQLite:(id)sender 
{
  //  ViewController *customerListViewController = [[ViewController alloc] init];
    [[self bookArray] removeAllObjects];
    [[self cameraArray] removeAllObjects];

    [[self musicArray] removeAllObjects];

    NSArray *bookList = [[SQLiteOperation shared] getAllBooks];
    NSArray *cameraDetailArray = [[SQLiteOperation shared] getAllcameraList];
    
    NSArray *musicDetailArray = [[SQLiteOperation shared] getAllMusicList];


    
       // Give the list to the main view controller
    [[self bookArray]addObjectsFromArray:bookList];
    [[self musicArray]addObjectsFromArray:musicDetailArray];
    [[self cameraArray]addObjectsFromArray:cameraDetailArray];

   
    
   

    [self.tableView reloadData];
    
   }
-(void)refreshBtnAction
{
    self.bookArray         = [[NSMutableArray alloc] init];
    self.cameraArray         = [[NSMutableArray alloc] init];
    self.musicArray       = [[NSMutableArray alloc] init];
    
    NSString *completeURLStr = [NSString stringWithFormat:@"http://www.kaverisoft.com/careers/assignments/iphone/a1.php"];
    NSLog(@"complete--->%@",completeURLStr);
    
    dispatch_async(kBgQueue, ^{
        
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:completeURLStr]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        //        
    });

    
}


@end
