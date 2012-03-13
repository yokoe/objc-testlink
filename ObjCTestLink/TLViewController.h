//
//  TLViewController.h
//  ObjCTestLink
//
//  Created by Sota Yokoe on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txtEndPointURL;
@property (retain, nonatomic) IBOutlet UITextField *txtDevKey;
@property (retain, nonatomic) IBOutlet UITextField *txtTestcaseID;
@property (retain, nonatomic) IBOutlet UITextField *txtTestplanID;
@property (retain, nonatomic) IBOutlet UITextField *txtBuildID;
@end
