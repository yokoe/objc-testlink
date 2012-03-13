//
//  TLViewController.m
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TLViewController.h"


NSString *const kTLEndpointURL = @"EndPointURL";
NSString *const kTLDevKey = @"DevKey";
NSString *const kTLTestCaseID = @"TestCaseID";
NSString *const kTLTestPlanID = @"TestPlanID";
NSString *const kTLBuildID = @"BuildID";

@interface TLViewController ()

@end

@implementation TLViewController
@synthesize txtEndPointURL;
@synthesize txtDevKey;
@synthesize txtTestcaseID;
@synthesize txtTestplanID;
@synthesize txtBuildID;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Restore settings
#define SetValueToTextField(field, key) (field.text = [[NSUserDefaults standardUserDefaults] objectForKey:key])
    SetValueToTextField(txtBuildID, kTLBuildID);
    SetValueToTextField(txtDevKey, kTLDevKey);
    SetValueToTextField(txtEndPointURL, kTLEndpointURL);
    SetValueToTextField(txtTestcaseID, kTLTestCaseID);
    SetValueToTextField(txtTestplanID, kTLTestPlanID);
#undef SetValueToTextField
}

- (void)viewDidUnload
{
    [self setTxtEndPointURL:nil];
    [self setTxtDevKey:nil];
    [self setTxtTestcaseID:nil];
    [self setTxtTestplanID:nil];
    [self setTxtBuildID:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (NSString*)requestBodyWithDevKey:(NSString*)devKey testPlanID:(int)testPlanID testCaseID:(int)testCaseID buildID:(int)buildID status:(NSString*)status {
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
- (void)sendReportAsStatus:(NSString*)status {
    // Save settings
#define SetValueToUserDefaults(field, key) ([[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key])
    SetValueToUserDefaults(txtBuildID, kTLBuildID);
    SetValueToUserDefaults(txtDevKey, kTLDevKey);
    SetValueToUserDefaults(txtEndPointURL, kTLEndpointURL);
    SetValueToUserDefaults(txtTestcaseID, kTLTestCaseID);
    SetValueToUserDefaults(txtTestplanID, kTLTestPlanID);
    [[NSUserDefaults standardUserDefaults] synchronize];
#undef SetValueToUserDefaults
    
    // Generate request body
    NSString* bodyString = [self requestBodyWithDevKey:txtDevKey.text testPlanID:[txtTestplanID.text intValue] testCaseID:[txtTestplanID.text intValue] buildID:[txtBuildID.text intValue] status:status];
    
    // Post
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:txtEndPointURL.text] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
                                                       timeoutInterval:60.0]; 
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSLog(@"Response: %@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
        } else {
            NSLog(@"Connection error: %@", error);
            if (data) {
                NSLog(@"Response: %@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
            }
        }
    }]; 
}

- (IBAction)reportAsPassed:(id)sender {
    [self sendReportAsStatus:@"p"];
}
- (IBAction)reportAsFailed:(id)sender {
    [self sendReportAsStatus:@"f"];
}
- (void)dealloc {
    [txtEndPointURL release];
    [txtDevKey release];
    [txtTestcaseID release];
    [txtTestplanID release];
    [txtBuildID release];
    [super dealloc];
}
@end
