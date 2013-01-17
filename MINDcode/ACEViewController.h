//
//  ACEViewController.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SourceDocument.h"

@interface ACEViewController : NSViewController <ACEViewDelegate>

@property (nonatomic, unsafe_unretained) SourceDocument *sourceDocument;

@end