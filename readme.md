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