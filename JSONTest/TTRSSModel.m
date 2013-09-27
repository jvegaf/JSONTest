//
//  TTRSSModel.m
//  JSONTest
//
//  Created by JOSE VEGA on 14/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import "TTRSSModel.h"
#import "TTRSSCategoryModel.h"
#import "TTRSSFeedModel.h"
#import "TTRSSHeadlinesModel.h"

@implementation TTRSSModel

@synthesize op,login,user,password,admin,sid,isLoggedIn,logout,getUnread,getFeeds,getCategories,getHeadlines,getArticle,fetchData,unsubscribeFeed,url,keys,objects,session_id,questionDict,categories,feeds,headlines;


-(id) init
{
    if ((self = [super init])){
        op = @"op";
        login = @"login";
        user = @"user";
        password = @"password";
        admin = @"admin";
        sid = @"sid";
        isLoggedIn = @"isLoggedIn";
        logout = @"logout";
        getUnread = @"getUnread";
        getFeeds = @"getFeeds";
        getCategories = @"getCategories";
        getHeadlines = @"getHeadlines";
        getArticle = @"getArticle";
        fetchData = @"fetchData";
        unsubscribeFeed = @"unsubscribeFeed";
        url = [NSURL URLWithString:@"http://tosukapetaka.dyndns.info/tt-rss/api/"];
    }
    return self;
}

#pragma mark - connections

-(void)startConnection
{
    // prepare the dictionary
    keys = @[op,user,password];
    objects = @[login,admin,admin];
    // create the d¡ctionary
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    // transform to JSON
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    // prepare the JSON request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    // send request
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    // get the response
    if (data != nil) {
        NSLog(@"RESPONSE: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //test
//            NSLog(@"diccionario count: %lu",[JSONObjects count]);
//            for (NSString *key in JSONObjects) {
//                NSLog(@"%@",key);
//            }
        NSDictionary *content = [JSONObjects valueForKey:@"content"];
        //test
//            NSLog(@"%lu",[content count]);
//            for (NSString *key in content) {
//                NSLog(@"%@",key);
//            }
        session_id = [content valueForKey:@"session_id"];
        //test
        NSLog(@"session id = %@",session_id);
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)isLoggedInWithID
{
    keys = @[sid,op];
    objects = @[session_id,isLoggedIn];
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSLog(@"isLoggedIn RESPONSE: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}


-(void)stopConectionWithID
{
    keys = @[sid,op];
    objects = @[session_id,logout];
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSLog(@"stopConnection RESPONSE: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
}

#pragma mark - methods

-(void)getCategoriesWithID
{
    keys = @[sid,op];
    objects = @[session_id,getCategories];
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSLog(@"getCategories RESPONSE: %@ \n\n\n\n\n\n",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        NSDictionary *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //NSLog(@"%@",JSONObjects);
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        //test
//		NSLog(@"contents count: %lu",[contents count]);
//      NSLog(@"content 1 = %@",[contents objectAtIndex:0]);
        categories = [[NSMutableArray alloc]init];
        for (NSDictionary *category in contents) {
            //Create categoy object
            TTRSSCategoryModel *cat = [[TTRSSCategoryModel alloc]initWithDictionary:category];
            //add object to array
            [categories addObject:cat];
            NSLog(@"categoy added: %@",[cat title]);
        }
        //Test
        NSLog(@"number of categories in Array: %lu",[categories count]);
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
}



-(void)getFeedsWithID
{
    keys = @[sid,op,@"cat_id"];
    objects = @[session_id,getFeeds,@"-4"];
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        //test
        //NSLog(@"getFeeds RESPONSE: %@\n\n\n\n",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        NSDictionary *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //test
        //NSLog(@"getFeeds Dict = %@",JSONObjects);
        feeds = [[NSMutableArray alloc] init];
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        // test
        NSLog(@"contents items: %lu",[contents count]);
        for (NSDictionary *aFeeds in contents) {
            TTRSSFeedModel *feed = [[TTRSSFeedModel alloc] initWithDictionary:aFeeds];
            [feeds addObject:feed];
            NSLog(@"feed added: %@",[feed title]);
        }
        //test
        NSLog(@"\n\n\n\n number of feeds: %lu \n\n\n\n",[feeds count]);
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)getHeadlinesWithID
{
    keys = @[sid,op,@"feed_id"];
    objects = @[session_id,getHeadlines,@"4"];
    questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        //test
        //NSLog(@"getHeadlines RESPONSE: %@\n\n\n\n",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        NSDictionary *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //test
        //NSLog(@"getHeadlines Dict = %@",JSONObjects);
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        //test
        NSLog(@"content items: %lu",[contents count]);
        headlines = [[NSMutableArray alloc]init];
        
        for (NSDictionary *aHeadline in contents) {
            TTRSSHeadlinesModel *head = [[TTRSSHeadlinesModel alloc]initWithDictionary:aHeadline];
            [headlines addObject:head];
            //test
            NSLog(@"headline title: %@",[head title]);
        }
        //test
        NSLog(@"\n\n\n\n number of headlines: %lu \n\n\n\n",[headlines count]);
        
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}




@end
