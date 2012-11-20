//
//  SQLiteOperation.h
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>
#import "BookDatabase.h"
#import "CameraDatabase.h"
#import "musicDatabase.h"

@interface SQLiteOperation : NSObject {
	sqlite3 *mDatabase;
}

+ (SQLiteOperation *)shared;
- (void)addEmployee:(BookDatabase *)book;
- (void)addCamera:(CameraDatabase *)camera;
- (void)addMusic:(musicDatabase *)music;



- (NSArray *)getAllBooks;
- (NSArray *)getAllMusicList;
- (NSArray *)getAllcameraList;



- (void)cleanAllDataFromBook;
- (void)cleanAllDataFromMusic;
- (void)cleanAllDataFromCamera;



//- (NSString *)urlEncodeValue:(NSString *)str ;
//- (NSString *)urlEncodeValue:(NSString *)str ;

@end
