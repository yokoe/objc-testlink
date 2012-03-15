//
//  TLViewController.m
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TLViewController.h"

#import "SYTestLink.h"

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
    SYTestLink* tl = [[[SYTestLink alloc] initWithEndpointURL:txtEndPointURL.text devKey:txtDevKey.text testPlanID:[txtTestplanID.text intValue] buildID:[txtBuildID.text intValue]] autorelease];
    int testCaseID = [txtTestcaseID.text intValue];
    if ([status isEqualToString:@"p"]) {
        [tl sendReportAsPassedForTestCaseID:testCaseID];
    }
    if ([status isEqualToString:@"f"]) {
        [tl sendReportAsFailedForTestCaseID:testCaseID];
    }
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
