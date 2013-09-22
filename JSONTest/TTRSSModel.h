//
//  TTRSSModel.h
//  JSONTest
//
//  Created by JOSE VEGA on 14/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRSSModel : NSObject

@property (nonatomic,copy) NSString *op;
@property (nonatomic,copy) NSString *login;
@property (nonatomic,copy) NSString *user;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *admin;
@property (nonatomic,copy) NSString *sid;
@property (nonatomic,copy) NSString *isLoggedIn;
@property (nonatomic,copy) NSString *logout;
@property (nonatomic,copy) NSString *getUnread;
@property (nonatomic,copy) NSString *getFeeds;
@property (nonatomic,copy) NSString *getCategories;
@property (nonatomic,copy) NSString *getHeadlines;
@property (nonatomic,copy) NSString *getArticle;
@property (nonatomic,copy) NSString *fetchData;
@property (nonatomic,copy) NSString *unsubscribeFeed;

@property (nonatomic,strong) NSArray *keys;
@property (nonatomic,strong) NSArray *objects;
@property (nonatomic,strong) NSDictionary *questionDict;
@property (nonatomic,copy) NSString *session_id;
@property (nonatomic,strong) NSURL *url;

@property (nonatomic,strong) NSMutableArray *categories;



-(void)startConnection;
-(void)stopConectionWithID;
-(void)getCategoriesWithID;
-(void)isLoggedInWithID;
-(void)getFeedsWithID;

@end
