//
//  UploadProgressWindowController.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "UploadProgressWindowController.h"
#import "ProgressWindowController+Protected.h"

@interface UploadProgressWindowController ()

@property (nonatomic, strong) MRNXTDevice *device;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSUInteger currIdx;
@property (nonatomic, assign) BOOL completed;

- (void)openWrite;
- (void)enqueueWrites:(uint8_t)handle;
- (void)done:(uint8_t)handle;

@end


@implementation UploadProgressWindowController

#define WRITE_BLOCK_SIZE 58

- (id)initWithSourceURL:(NSURL *)url device:(MRNXTDevice *)device {
	self = [super init];
    
	if (self) {
        self.fileName = [url lastPathComponent];
		self.data = [[NSData alloc] initWithContentsOfURL:url];
        self.device = device;
	}
    
	return self;
}

- (void)windowDidLoad {
	[super windowDidLoad];
    
    self.promptTextField.stringValue =
    [NSString stringWithFormat:NSLocalizedString(@"UploadProgressWindowControllerMessageFormat", nil), self.fileName];
    
    [self performSelector:@selector(prepareForUpload) withObject:self afterDelay:0];
}

- (void) prepareForUpload {
    // First delelte the file if it exists
    MRNXTDeleteCommand *del = [[MRNXTDeleteCommand alloc] init];
    del.filename = self.fileName;
    [self.device enqueueCommand:del responseBlock:^(MRNXTResponse *resp) {
        [self openWrite];
    }];
}

- (void)openWrite {
	
    // Now open a write operation
	MRNXTOpenWriteCommand *owc = [[MRNXTOpenWriteCommand alloc] init];
	owc.size = [self.data length];
	owc.filename = self.fileName;
	
	[self.device enqueueCommand:owc responseBlock:^(MRNXTHandleResponse *resp) {
		if (resp.status == NXTStatusSuccess) {
			[self enqueueWrites:resp.handle];
		} else {
            [self done:resp.handle];
        }
	}];
}

- (void)enqueueWrites:(uint8_t)handle {
	NSUInteger totalLength = [self.data length];
	
    __block BOOL breakLoop = NO;
    
	for (uint16_t idx = 0; idx < totalLength; idx += WRITE_BLOCK_SIZE) {
		NSUInteger bytesToWrite = MIN_INT(totalLength - idx, WRITE_BLOCK_SIZE);
        
		MRNXTWriteCommand *wr = [[MRNXTWriteCommand alloc] init];
		wr.handle = handle;
		wr.data = [self.data subdataWithRange:NSMakeRange(idx, bytesToWrite)];
		
		[self.device enqueueCommand:wr responseBlock:^(MRNXTHandleSizeResponse *resp) {
            if (resp.status == NXTStatusSuccess) {
                self.currIdx += resp.size;
                [self.progressIndictor setDoubleValue:(self.currIdx / (float) totalLength)];
            } else {
                breakLoop = YES;
            }
		}];
        
        if (breakLoop) {
            break;
        }
	}
	
    self.completed = !breakLoop;
	[self done:handle];
}

- (void)done:(uint8_t)handle {
    MRNXTCloseCommand *cc = [[MRNXTCloseCommand alloc] init];
    cc.handle = handle;
	
    [self.device enqueueCommand:cc responseBlock:^(MRNXTResponse *resp) {
        [self dismissSheet];
    }];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super didEndSheet:sheet returnCode:returnCode contextInfo:contextInfo];
    
    if (self.delegate) {
        [self.delegate uploadProgressWindowController:self didFinishUploadingFile:self.fileName withSuccess:self.completed];
    }
}

@end