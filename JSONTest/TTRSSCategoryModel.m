//
//  TTRSSCategoryModel.m
//  JSONTest
//
//  Created by JOSE VEGA on 18/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import "TTRSSCategoryModel.h"

@implementation TTRSSCategoryModel

-(id)initWithCatID:(NSUInteger)aCatid
             title:(NSString *)aTitle
            unread:(NSUInteger)aUnread
           orderid:(NSUInteger)aOrder
{
    if (self = [super init]) {
        _catID = aCatid;
        _title = aTitle;
        _unread = aUnread;
        _orderID= aOrder;
    }
    
    return self;

}

-(id)initWithDictionary:(NSDictionary *)aDict
{
    return [self initWithCatID:[aDict objectForKey:@"catID"]
                         title:[aDict objectForKey:@"title"]
                        unread:[aDict objectForKey:@"unread"]
                       orderid:[aDict objectForKey:@"orderID"]];

}



@end
