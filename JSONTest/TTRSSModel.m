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
#import "TTRSSArticleModel.h"

@implementation TTRSSModel


-(id) init
{
    if ((self = [super init])){
        
        _defaults = [NSUserDefaults standardUserDefaults];
        _url = [NSURL URLWithString:[_defaults objectForKey:@"URL"]];
        NSLog(@"URL:%@",_url);
        //_url = [NSURL URLWithString:@"http://10.0.1.207/tt-rss/api/"];
    }
    return self;
}

#pragma mark - connections

-(void)startConnection
{
    // prepare the dictionary
    _keys = @[@"op",@"user",@"password"];
    _objects = @[@"login",[_defaults objectForKey:@"USERNAME"],[_defaults objectForKey:@"PASSWORD"]];
    // create the d¡ctionary
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    // transform to JSON
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    // prepare the JSON request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    // send request
    NSURLResponse *response = [[NSURLResponse alloc] init];
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
        _session_id = [content valueForKey:@"session_id"];
        //test
        NSLog(@"session id = %@",_session_id);
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)isLoggedInWithSessionID:(NSString *)aSID
{
    _keys = @[@"sid",@"op"];
    _objects = @[aSID,@"isLoggedIn"];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
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


-(void)stopConectionWithSessionID:(NSString *)aSID
{
    _keys = @[@"sid",@"op"];
    _objects = @[aSID,@"logout"];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSLog(@"stopConnection RESPONSE: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
}

#pragma mark - methods

-(void)getCategoriesWithSessionID:(NSString *)aSID
{
    _keys = @[@"sid",@"op"];
    _objects = @[aSID,@"getCategories"];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse * response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        //test
        //NSLog(@"getCategories RESPONSE: %@ \n\n\n\n\n\n",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);;
        NSDictionary *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //NSLog(@"%@",JSONObjects);
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        //test
//		NSLog(@"contents count: %lu",[contents count]);
//      NSLog(@"content 1 = %@",[contents objectAtIndex:0]);
        _categories = [[NSMutableArray alloc]init];
        for (NSDictionary *category in contents) {
            //test
            //NSLog(@"category: %@",category);
            //Create category model object
            TTRSSCategoryModel *cat = [[TTRSSCategoryModel alloc]initWithDictionary:category];
            //add object to array
            [_categories addObject:cat];
            //test
            //NSLog(@"categoy added: %@",[cat title]);
            //NSLog(@"Cat ID: %d",cat.catID);
        }
        //Test
        NSLog(@"number of categories in Array: %d",[_categories count]);
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
}



-(void)getFeedsWithSessionID:(NSString *)aSID catID:(NSInteger)aCatID
{
    _keys = @[@"sid",@"op",@"cat_id"];
    _objects = @[aSID,@"getFeeds",[NSString stringWithFormat:@"%d",aCatID]];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
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
        _feeds = [[NSMutableArray alloc] init];
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        // test
        NSLog(@"contents items: %d",[contents count]);
        for (NSDictionary *aFeeds in contents) {
            TTRSSFeedModel *feed = [[TTRSSFeedModel alloc] initWithDictionary:aFeeds];
            [_feeds addObject:feed];
            NSLog(@"feed added: %@ withID: %d",[feed title],[feed feedID]);
        }
        //test
        NSLog(@"\n\n\n\n number of feeds: %d \n\n\n\n",[_feeds count]);
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)getHeadlinesWithSessionID:(NSString *)aSID FeedID:(NSInteger)aFeedID
{
    _keys = @[@"sid",@"op",@"feed_id",@"limit"];
    _objects = @[aSID,@"getHeadlines",[NSNumber numberWithInt:aFeedID],[NSNumber numberWithInt:50]];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
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
        NSLog(@"content items: %d",[contents count]);
        _headlines = [[NSMutableArray alloc]init];
        
        for (NSDictionary *aHeadline in contents) {
            TTRSSHeadlinesModel *head = [[TTRSSHeadlinesModel alloc]initWithDictionary:aHeadline];
            [_headlines addObject:head];
            //test
            NSLog(@"headline title: %@",[head title]);
            NSLog(@"articleID: %d",[head articleID]);
        }
        //test
        NSLog(@"\n\n\n\n number of headlines: %d \n\n\n\n",[_headlines count]);
        
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)getArticleWithSessionID:(NSString *)aSID articleID:(NSInteger)aArticleID
{
    _keys = @[@"sid",@"op",@"article_id"];
    _objects = @[aSID,@"getArticle",[NSNumber numberWithInt:aArticleID]];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
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
        //NSLog(@"article Dict = %@",JSONObjects);
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        //test
        NSLog(@"content items: %d",[contents count]);
        _articleObject = [[NSMutableArray alloc]init];
        
        for (NSDictionary *aArticle in contents) {
            TTRSSArticleModel *article = [[TTRSSArticleModel alloc]initWithDictionary:aArticle];
            [_articleObject addObject:article];
            //test
            NSLog(@"article content: %@",[article content]);
            NSLog(@"article link: %@",[article link]);
            _articleContent = [NSString stringWithString:[article content]];
            _articleContentCleaned = [NSString stringWithString:[article contentCleaned]];
            
        }
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

-(void)getConfigWithSessionID:(NSString *)aSID
{
    _keys = @[@"sid",@"op"];
    _objects = @[aSID,@"getConfig"];
    _questionDict = [NSDictionary dictionaryWithObjects:_objects forKeys:_keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_questionDict
                                                       options:kNilOptions error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
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
        //NSLog(@"getConfig Dict = %@",JSONObjects);
        NSArray *contents = [JSONObjects objectForKey:@"content"];
        //test
        NSLog(@"content items: %d",[contents count]);
              
        
    }
    else {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}



@end
