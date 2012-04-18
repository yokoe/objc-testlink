# objc-testlink

## Usage

`````
SYTestLink* testlink = [[SYTestLink alloc] initWithEndpointURL:PNTestLinkEndPointURL 
                                                       devKey:PNTestLinkDevKey 
                                                   testPlanID:PNTestLinkTestPlanID 
                                                      buildID:PNTestLinkBuildID];
// Do some test
if (testFailed) {
    [testLink sendReportAsPassedForTestCaseID:testCaseID];
} else {
    [testLink sendReportAsFailedForTestCaseID:testCaseID];
}

[testlink release];
`````

## Download

### Clone from git repository

`````
git clone https://github.com/yokoe/objc-testlink
`````

### Download the latest files
Just import these 2 files into your xcode project. No frameworks / libraries required.

  * https://github.com/yokoe/objc-testlink/blob/master/SYTestLink/SYTestLink.h
  * https://github.com/yokoe/objc-testlink/blob/master/SYTestLink/SYTestLink.m