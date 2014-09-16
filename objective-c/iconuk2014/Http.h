//
//  Http.h
//  iconuk2014
//
//  Created by René Winkelmeyer on 11.09.14.
//  Copyright (c) 2014 René Winkelmeyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpDelegate <NSObject>
@optional
- (void)returnDataFromServer:(NSArray *)people;
@end


@interface Http : NSObject

@property (strong, nonatomic) id<HttpDelegate> delegate;

-(void)loadDataFromServer;
-(void)updateUser:(NSMutableDictionary *)dictUser;

@end
