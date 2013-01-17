//
//  ACEViewController.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "ACEViewController.h"

@interface ACEViewController ()

@end

@implementation ACEViewController

-(void)loadView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super loadView];
    
    ACEView *aceView = (ACEView *)self.view;
    [aceView setMode:ACEModeCPP];
    [aceView setTheme:ACEThemeXcode];
    [aceView setShowInvisibles:NO];
    if (self.sourceDocument.content) {
        [aceView setString: self.sourceDocument.content];
    }
    [aceView setDelegate:self];
}

#pragma mark ACE View Delegate

- (void) textDidChange:(NSNotification *)notification {
    ACEView *aceView = (ACEView *)self.view;
    self.sourceDocument.content = aceView.string;
}

@end