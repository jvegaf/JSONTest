//
//  TTRSSCategoryModel.h
//  JSONTest
//
//  Created by JOSE VEGA on 18/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRSSCategoryModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic) NSUInteger catID;
@property (nonatomic) NSUInteger unread;
@property (nonatomic) NSUInteger orderID;


-(id)initWithCatID:(NSUInteger)aCatid
             title:(NSString *)aTitle
            unread:(NSUInteger)aUnread
           orderid:(NSUInteger)aOrder;


-(id)initWithDictionary:(NSDictionary *)aDict;


@end
