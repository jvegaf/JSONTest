//
//  TTRSSHeadlinesModel.m
//  JSONTest
//
//  Created by JOSE VEGA on 26/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import "TTRSSHeadlinesModel.h"

@implementation TTRSSHeadlinesModel

-(id) initWithFeedID:(NSInteger)aFeedID
              author:(NSString *)aAuthor
           feedTitle:(NSString *)aFeedtitle
                link:(NSURL *)aLink
               title:(NSString *)aTitle
             updated:(NSInteger)aUpdated
{
    if (self = [super init]) {
        aFeedID = _feedID;
        aAuthor = _author;
        aFeedID = _feedID;
        aLink = _link;
        aTitle = _title;
        aUpdated = _updated;
    }
    
    return self;
    
}

-(id) initWithDictionary:(NSDictionary *)aDict
{
    return [self initWithFeedID:[[aDict objectForKey:@"feed_id"]intValue] author:[aDict objectForKey:@"author"] feedTitle:[aDict objectForKey:@"feed_title"] link:[aDict objectForKey:@"link"] title:[aDict objectForKey:@"title"] updated:[[aDict objectForKey:@"updated"]intValue]];
}



@end
