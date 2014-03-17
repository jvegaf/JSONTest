//
//  main.m
//  JSONTest
//
//  Created by JOSE VEGA on 06/09/13.
//  Copyright (c) 2013 JOSE VEGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTRSSModel.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"http://10.0.1.207/tt-rss/api/" forKey:@"URL"];
        [defaults setObject:@"admin" forKey:@"USERNAME"];
        [defaults setObject:@"admin" forKey:@"PASSWORD"];
        
        TTRSSModel *prueba = [[TTRSSModel alloc]init];
        [prueba startConnection];
        [prueba isLoggedInWithSessionID:prueba.session_id];
        [prueba getCategoriesWithSessionID:prueba.session_id];
        [prueba getFeedsWithSessionID:prueba.session_id catID:2];
        [prueba getHeadlinesWithSessionID:prueba.session_id FeedID:6];
        [prueba getArticleWithSessionID:prueba.session_id articleID:16050];
        [prueba stopConectionWithSessionID:prueba.session_id];
        [prueba isLoggedInWithSessionID:prueba.session_id];
     
    }
    return 0;
}

