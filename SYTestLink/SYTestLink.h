//
//  SYTestLink.h
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYTestLink : NSObject
+ (NSString*)requestBodyWithDevKey:(NSString*)devKey testPlanID:(int)testPlanID testCaseID:(int)testCaseID buildID:(int)buildID status:(NSString*)status;
+ (void)sendReportToURL:(NSURL*)url withBody:(NSString*)body queue:(NSOperationQueue*)queue completionHandler:(void (^)(NSURLResponse* response, NSString* responseBody, NSError* error))completionHandler;
@end
