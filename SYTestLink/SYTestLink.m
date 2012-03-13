//
//  SYTestLink.m
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SYTestLink.h"

@implementation SYTestLink
+ (NSString*)requestBodyWithDevKey:(NSString*)devKey testPlanID:(int)testPlanID testCaseID:(int)testCaseID buildID:(int)buildID status:(NSString*)status {
    NSMutableArray* membersArray = [NSMutableArray array];
#define AddStringMember(key, value) ([membersArray addObject:[NSString stringWithFormat:@"<member><name>%@</name><value><string>%@</string></value></member>", key, value]])
#define AddStringMemberFromInt(key, value) AddStringMember(key, ([NSString stringWithFormat: @"%d", value]))
    AddStringMember(@"devKey", devKey);
    AddStringMemberFromInt(@"buildid", buildID);
    AddStringMemberFromInt(@"testcaseid", testCaseID);
    AddStringMemberFromInt(@"testplanid", testPlanID);
    AddStringMember(@"status", status);
#undef AddStringMember
#undef AddStringMemberFromInt
    
    NSString* members = [membersArray componentsJoinedByString:@""];
    return [NSString stringWithFormat:@"<methodCall><methodName>tl.reportTCResult</methodName><params><param><value><struct>%@</struct></value></param></params></methodCall>", members];
}

+ (void)sendReportToURL:(NSURL*)url withBody:(NSString*)body queue:(NSOperationQueue*)queue completionHandler:(void (^)(NSURLResponse* response, NSString* responseBody, NSError* error))completionHandler {
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0]; 
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (completionHandler) {
            completionHandler(response, data ? [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease] : nil, error);
        }
    }]; 
}
@end
