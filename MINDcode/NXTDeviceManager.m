//
//  NXTDeviceManager.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "NXTDeviceManager.h"

NSString *const kNXTDeviceManagerDidOpenDeviceNotification = @"kNXTDeviceManagerDidOpenDeviceNotification";
NSString *const kNXTDeviceManagerDidFailToOpenDeviceNotification = @"kNXTDeviceManagerDidFailToOpenDeviceNotification";
NSString *const kNXTDeviceManagerDidCloseDeviceNotification = @"kNXTDeviceManagerDidCloseDeviceNotification";


static NXTDeviceManager *gInstance = NULL;


@interface NXTDeviceManager()

@property (nonatomic, strong) MRNXTDevice *device;

@end


@implementation NXTDeviceManager

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;
        gInstance = [[NXTDeviceManager alloc] init];
    }
}

+ (NXTDeviceManager *) defaultManager {
    return gInstance;
}

- (BOOL) isConnected {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.device) {
        return YES;
    } else {
        return NO;
    }
}

- (void) connect {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.device) {
        [self.device close];
        self.device = nil;
    }
    
    MRDeviceTransport *transport = nil;
    
    // First look for NXT devices connected via USB
    NSArray *usbDevices = [MRUSBDeviceEntry matchingDevicesForProductID:0x2 vendorID:0x694];
    
    // If we found some, then use the first one by default
	if ([usbDevices count]) {
        // Take the first device. Perhaps in the future we may want to provide a way to select different ones
		MRUSBDeviceEntry *entry = [usbDevices objectAtIndex:0];
		
		NSArray *pipes = [NSArray arrayWithObjects:
						  [MRUSBDevicePipeDescriptor pipeDescriptorWithTransferType:MRUSBTransferTypeBulk
																		  direction:MRUSBTransferDirectionIn],
						  [MRUSBDevicePipeDescriptor pipeDescriptorWithTransferType:MRUSBTransferTypeBulk
																		  direction:MRUSBTransferDirectionOut], nil];
		
		transport = [[MRUSBDeviceTransport alloc] initWithDeviceEntry:entry desiredPipes:pipes];
	} else {
		IOBluetoothDeviceSelectorController *bluetoothDeviceSelectorController = [IOBluetoothDeviceSelectorController deviceSelector];
        int result = [bluetoothDeviceSelectorController runModal];
        
        if (result == kIOBluetoothUISuccess) {
            NSArray *results = [bluetoothDeviceSelectorController getResults];
            
            if ([results count]) {
                IOBluetoothDevice *firstDevice = [results objectAtIndex:0];
                transport = [[MRBluetoothDeviceTransport alloc] initWithBluetoothDevice:firstDevice];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNXTDeviceManagerDidCloseDeviceNotification object:self];
            }
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNXTDeviceManagerDidCloseDeviceNotification object:self];
        }
	}
    
    if (transport) {
        NSError *error = nil;
        
        self.device = [[MRNXTDevice alloc] initWithTransport:transport];
        [self.device setDelegate:self];
        
        if (![self.device open:&error]) {
            [self.device close];
            self.device = nil;
        }
    }
}

#pragma mark Device Delegate

- (void)deviceDidOpen:(MRDevice *)aDevice {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNXTDeviceManagerDidOpenDeviceNotification object:self];
}

- (void)device:(MRDevice *)aDevice didFailToOpen:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNXTDeviceManagerDidFailToOpenDeviceNotification object:self userInfo:@{@"error":error}];
}

- (void)deviceDidClose:(MRDevice *)aDevice {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self.device close];
    self.device = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNXTDeviceManagerDidCloseDeviceNotification object:self];
}

@end