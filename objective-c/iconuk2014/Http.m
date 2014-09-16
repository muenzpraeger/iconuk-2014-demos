//
//  Http.m
//  iconuk2014
//
//  Created by René Winkelmeyer on 11.09.14.
//  Copyright (c) 2014 René Winkelmeyer. All rights reserved.
//

#import "Http.h"

@interface Http()

@end

@implementation Http

-(Http *)init {

    return self;
}


-(void)loadDataFromServer {
    
    // This method calls a local JSON service and get's back an array of people.
    //
    // Example JSON:
    //
    // {"content": [{"firstName":"René", "lastName":"Winkelmeyer","mail":"mail@winkelmeyer.com"}]}
    
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/service/users/getall"];
    
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self addAuthoriationHeaderForRequest:request];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *persons = [json objectForKey:@"content"];
    
    [self.delegate returnDataFromServer:persons]; // The array is passed back to the UI table.
    
}

-(void)updateUser:(NSMutableDictionary *)dictUser {
    
    // This method calls a local JSON service and sends a JSON dict for updating an entry.
    //
    // Example JSON:
    //
    // {"firstName":"René", "lastName":"Winkelmeyer","mail":"mail@winkelmeyer.com"}
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/service/users/update"];
    
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictUser
                                                       options:0
                                                         error:&error];
    
    [request setHTTPBody:jsonData];
    
    [self addAuthoriationHeaderForRequest:request];

    
    [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil error:&error];
    
}

-(void)addAuthoriationHeaderForRequest:(NSMutableURLRequest *)request {
    
    // Helper method for creating a basic login authentication.
    NSString *userName = @"YourUserName";
    NSString *password = @"YourPassword";
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", userName, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64Encoding]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
}

@end
