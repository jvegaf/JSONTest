//
//  main.m
//  JSONTest
//
//  Created by JOSE VEGA on 06/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // prepare the dictionary
        
        NSArray *keys = @[@"op",@"user",@"password"];
        NSArray *objects = @[@"login",@"admin",@"admin"];
        // create the dictionary
        NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        NSLog(@"DICTIONARY %@",questionDict);
        // transform to json
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict options:NSJSONWritingPrettyPrinted error:&error];
        NSLog(@"JSON DATA: %@",[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding]);
        // prepare JSON request
        NSURL *url = [NSURL URLWithString:@"http://tosukapetaka.dyndns.info/tt-rss/api/"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:jsonData];
        // send request
        NSURLResponse * response = [[NSURLResponse alloc] init];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *session_id;
        
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
            NSLog(@"Error al parsear JSON: %@",error.localizedDescription);
        }
        
        NSString *newJSONRequest = [NSString stringWithFormat:@"{'sid':'%@','op':'isLoggedIn'}",session_id];
        NSLog(@"new request: %@",newJSONRequest);
        // hacer una peticion isLoggedIn
        
     
    }
    return 0;
}

