//
//  TTRSSFeedModel.m
//  JSONTest
//
//  Created by JOSE VEGA on 25/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import "TTRSSFeedModel.h"

@implementation TTRSSFeedModel


-(id)initWithFeedURL:(NSURL *)aFeedURL
               title:(NSString *)aTitle
              feedID:(NSInteger)aFeedID
              unread:(NSInteger)aUnread
             hasIcon:(BOOL)aHasIcon
               catID:(NSInteger)aCatID
         lastUpdated:(NSInteger)aLastUpdated
             orderID:(NSInteger)aOrderID
{
    if (self = [super init]) {
        _feedURL = aFeedURL;
        _title = aTitle;
        _feedID = aFeedID;
        _unread = aUnread;
        _hasIcon = aHasIcon;
        _catID = aCatID;
        _lastUpdated = aLastUpdated;
        _orderID = aOrderID;
    }
    return self;
}

-(id)initWhitDictionary:(NSDictionary *)aDict
{
    return [self initWithFeedURL:[aDict objectForKey:@"feedURL"]
                           title:[aDict objectForKey:@"title"]
                          feedID:[[aDict objectForKey:@"feedID"]intValue]
                          unread:[[aDict objectForKey:@"unread"]intValue]
                         hasIcon:[[aDict objectForKey:@"hasIcon"]boolValue]
                           catID:[[aDict objectForKey:@"catID"]intValue]
                     lastUpdated:[[aDict objectForKey:@"lastUpdated"]intValue]
                         orderID:[[aDict objectForKey:@"orderID"]intValue]];
}


@end

