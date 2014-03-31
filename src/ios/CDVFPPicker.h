
#import <Cordova/CDVPlugin.h>
#import <FPPicker/FPPicker.h>

@interface CDVFPPicker : CDVPlugin <FPPickerDelegate>
{
}

- (CDVFPPicker*)init;

- (void)getFile:(CDVInvokedUrlCommand*)command;

@end
