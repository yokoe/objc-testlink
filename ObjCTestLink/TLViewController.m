//
//  TLViewController.m
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TLViewController.h"

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
- (IBAction)reportAsPassed:(id)sender {
    NSLog(@"Passed");
}
- (IBAction)reportAsFailed:(id)sender {
    NSLog(@"Failed");
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
