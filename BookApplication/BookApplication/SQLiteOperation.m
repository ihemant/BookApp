//
//  SQLiteOperation.m
//  Demo
//
//  Created by Coco on 25-5-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "SQLiteOperation.h"

#define DATABASE_FILE_NAME @"productDetail.sqlite"

@interface SQLiteOperation()

@property (nonatomic, assign) sqlite3 *mDatabase;

#define create _creates
-(BOOL)_creates;
-(NSString*)_getDataSourcePath;

@end

@implementation SQLiteOperation

@synthesize mDatabase;

static SQLiteOperation *mSharedSQLiteOperation;

+ (SQLiteOperation *)shared {
	@synchronized(self) {
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [[self alloc] init];
			if (![mSharedSQLiteOperation create]) {
				return nil;
			}
		}
	}
	return mSharedSQLiteOperation;
}

- (NSString*)_getDataSourcePath{
	NSArray* fileDictory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path =  [[fileDictory objectAtIndex:0] stringByAppendingPathComponent:DATABASE_FILE_NAME];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		if (![[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME] toPath:path error:nil]) {
            NSLog(@"Cannot copy database to Documents folder");
            return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME];
		}
    }
    NSLog(@"path---->%@",path);
    return path;
}

- (BOOL)openDataBase {
	NSString *databasePath = [mSharedSQLiteOperation _getDataSourcePath];
	if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
		sqlite3_close(mDatabase);
    }
	return YES;
}

- (BOOL)_creates {
	NSString *databasePath = [mSharedSQLiteOperation _getDataSourcePath];
	if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
		sqlite3_close(mDatabase);
        
	}
	
    //	NSString *create_table_Sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(ROW INTEGER \
    //								  PRIMARY KEY AUTOINCREMENT,NAME TEXT,AGE TEXT,SEX TEXT,TEL TEXT)",tableName];
    //	
    //	char *errmsg;
    //	if(sqlite3_exec(mDatabase, [create_table_Sql UTF8String], NULL, NULL,&errmsg)!=SQLITE_OK)
    //	{
    //		NSAssert(0,@"create table failed",errmsg);
    //		return NO;
    //	}
	return YES;
}

+ (id)allocWithZone:(NSZone *)zone{
	@synchronized(self)	{
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [super allocWithZone:zone];
			return mSharedSQLiteOperation;
		}
	}
	return nil;
}

- (void)addEmployee:(BookDatabase *)book {
    if (book) {
        if ([self openDataBase]) {
         
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO book VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",book.authors ,book.description,book.price,book.title];
    
            sqlite3_stmt *statement = nil;
            if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
                NSLog(@"Add employee error");
            
            while(sqlite3_step(statement) == SQLITE_DONE){}
            sqlite3_finalize(statement);
            
            sqlite3_close(mDatabase);
        }
    }
}
- (void)addCamera:(CameraDatabase *)camera
{
    if (camera) {
        if ([self openDataBase]) {
    
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO camera VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",camera.make,camera.model,camera.picture,camera.price];
            
            NSLog(@"sql---->%@",sql);
            sqlite3_stmt *statement = nil;
            if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
                NSLog(@"Add employee error");
            
            while(sqlite3_step(statement) == SQLITE_DONE){}
            sqlite3_finalize(statement);
            
            sqlite3_close(mDatabase);
        }
    }
}
- (void)addMusic:(musicDatabase *)music
{
    if (music) {
        if ([self openDataBase]) {
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO music VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",music.album,music.artist,music.genre,music.title];
            
            NSLog(@"sql---->%@",sql);
            sqlite3_stmt *statement = nil;
            if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
                NSLog(@"Add employee error");
            
            while(sqlite3_step(statement) == SQLITE_DONE){}
            sqlite3_finalize(statement);
            
            sqlite3_close(mDatabase);
        }
    }
}
- (NSArray *)getAllMusicList
{
    NSMutableArray *musicDetailArray = [[NSMutableArray alloc] init];
    
    if ([self openDataBase]) {
        NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM Music"];
        
        sqlite3_stmt *query_stmt = nil;
        if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
            while (sqlite3_step(query_stmt) == SQLITE_ROW) {
                if (sqlite3_column_count(query_stmt) > 0) {
                    char *album = (char*)sqlite3_column_text(query_stmt, 0);
                    char *artist = (char*)sqlite3_column_text(query_stmt, 1);
                    char *genre = (char*)sqlite3_column_text(query_stmt, 2);
                    char *title = (char*)sqlite3_column_text(query_stmt, 3);
                    // int idStr = (int)sqlite3_column_int(query_stmt, 4);
                    
                    
                    musicDatabase *cameraObj = [musicDatabase new];
                    
                    cameraObj.album = [NSString stringWithUTF8String:album];
                    if (artist != NULL) {
                        cameraObj.artist = [NSString stringWithUTF8String:artist];
                    }
                    if (genre != NULL) {
                        cameraObj.genre = [NSString stringWithUTF8String:genre];
                    }
                    if (title != NULL) {
                        cameraObj.title = [NSString stringWithUTF8String:title];
                    }                    
                    
                    [musicDetailArray addObject:cameraObj];
                }
            }
        }
        sqlite3_close(mDatabase);
    }
	return [musicDetailArray autorelease];
}
- (NSArray *)getAllcameraList
{
    NSMutableArray *cameraDetailArray = [[NSMutableArray alloc] init];
    
    if ([self openDataBase]) {
        NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM camera"];
        
        sqlite3_stmt *query_stmt = nil;
        if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
            while (sqlite3_step(query_stmt) == SQLITE_ROW) {
                if (sqlite3_column_count(query_stmt) > 0) {
                    char *make = (char*)sqlite3_column_text(query_stmt, 0);
                    char *model = (char*)sqlite3_column_text(query_stmt, 1);
                    char *picture = (char*)sqlite3_column_text(query_stmt, 2);
                    int price = (int)sqlite3_column_int(query_stmt, 3);
                   // int idStr = (int)sqlite3_column_int(query_stmt, 4);
                    
                    
                    CameraDatabase *cameraObj = [CameraDatabase new];
                    
                    cameraObj.make = [NSString stringWithUTF8String:make];
                    if (model != NULL) {
                        cameraObj.model = [NSString stringWithUTF8String:model];
                    }
                    if (picture != NULL) {
                        cameraObj.picture = [NSString stringWithUTF8String:picture];
                    }
                    cameraObj.price = [NSString stringWithFormat:@"%d",price];
                    
                    
                    [cameraDetailArray addObject:cameraObj];
                }
            }
        }
        sqlite3_close(mDatabase);
    }
	return [cameraDetailArray autorelease];
}


- (NSArray *)getAllBooks {
    NSMutableArray *bookDetailArray = [[NSMutableArray alloc] init];

    if ([self openDataBase]) {
        NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM book"];
        
        sqlite3_stmt *query_stmt = nil;
        if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
            while (sqlite3_step(query_stmt) == SQLITE_ROW) {
                if (sqlite3_column_count(query_stmt) > 0) {
                    
                    char *titleStr = (char*)sqlite3_column_text(query_stmt, 3);
                    char *authorStr = (char*)sqlite3_column_text(query_stmt, 0);
                    char *descriptionStr = (char*)sqlite3_column_text(query_stmt, 1);
                    int priceStr = (int)sqlite3_column_int(query_stmt, 2);

                    
                    BookDatabase *book = [BookDatabase new];
                    
                    book.title = [NSString stringWithUTF8String:titleStr];
                    if (authorStr != NULL) {
                        book.authors = [NSString stringWithUTF8String:authorStr];
                    }
                    if (descriptionStr != NULL) {
                        book.description = [NSString stringWithUTF8String:descriptionStr];
                    }
                    book.price = [NSString stringWithFormat:@"%d",priceStr];
                 //   employee.id = [NSString stringWithFormat:@"%d",idStr];

                    
                    [bookDetailArray addObject:book];
                }
            }
        }
        sqlite3_close(mDatabase);
    }
	return [bookDetailArray autorelease];
}

- (void)cleanAllDataFromBook
{
    if ([self openDataBase]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM book"];
       // sql =[sql stringByAppendingFormat:@"DELETE FROM music"];
       // sql =[sql stringByAppendingFormat:@"DELETE FROM camera"];

        
        sqlite3_stmt *statement = nil;
        if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
            NSLog(@"Delete all data error");
        
        sqlite3_step(statement);
        sqlite3_finalize(statement);
        sqlite3_close(mDatabase);
    }
}


- (void)cleanAllDataFromMusic
{
    if ([self openDataBase]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM music"];
        sqlite3_stmt *statement = nil;
        if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
            NSLog(@"Delete all data error");
        
        sqlite3_step(statement);
        sqlite3_finalize(statement);
        sqlite3_close(mDatabase);
    }
}
- (void)cleanAllDataFromCamera
{
    if ([self openDataBase]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM camera"];
        sqlite3_stmt *statement = nil;
        if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
            NSLog(@"Delete all data error");
        
        sqlite3_step(statement);
        sqlite3_finalize(statement);
        sqlite3_close(mDatabase);
    }
}

/*
+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str
{
    NSMutableString* string = [[NSMutableString alloc] initWithString:str];  // #&39; replace with '
    NSString* unicodeStr = nil;
    NSString* replaceStr = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar char1 = [string characterAtIndex:i]; 
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar char2 = [string characterAtIndex:k]; 
            
            if (char1 == '&'  && char2 == '#' ) 
            { 
                ++counter;
                unicodeStr = [string substringWithRange:NSMakeRange(i + 2 , 2)]; // read integer value i.e, 39
                replaceStr = [string substringWithRange:NSMakeRange (i, 5)];  // #&39;
                [string replaceCharactersInRange: [string rangeOfString:replaceStr] withString:[NSString stringWithFormat:@"%c",[unicodeStr intValue]]];
                break;
            }
        }
    }
    
    [string autorelease];
    
    if (counter > 1)
        return [self decodeHtmlUnicodeCharactersToString:string]; 
    else
        return string;
}

- (NSString *)urlEncodeValue:(NSString *)str 
{
    
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
   return [result autorelease];
}
*/
@end
