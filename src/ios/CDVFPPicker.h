
#import <Cordova/CDVPlugin.h>

@interface CDVFPPicker : CDVPlugin
{
}

NSString* callbackId;

- (CDVSystemLog*)init;

- (void)getFile:(CDVInvokedUrlCommand*)command;

@end
