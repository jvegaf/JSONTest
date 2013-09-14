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
        
        TTRSSModel *prueba = [[TTRSSModel alloc]init];
        [prueba startConnection];
        [prueba isLoggedInWithID];
        [prueba getCategoriesWithID];
        [prueba stopConectionWithID];
        [prueba isLoggedInWithID];
     
    }
    return 0;
}

