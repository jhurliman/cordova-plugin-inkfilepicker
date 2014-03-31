
#import "CDVFPPicker.h"

@implementation CDVFPPicker

NSString* callbackId;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (void)getFile:(CDVInvokedUrlCommand*)command
{
    FPPickerController *fpController = [[FPPickerController alloc] init];
    fpController.fpdelegate = self;

    callbackId = command.callbackId;
    NSDictionary *options = [command.arguments objectAtIndex:0];

    if (options[@"allowsEditing"] != nil) {
      fpController.allowsEditing = [options[@"allowsEditing"] boolValue];
    }

    if ([options[@"dataTypes"] isKindOfClass:[NSArray class]]) {
      fpController.dataTypes = options[@"dataTypes"];
    }

    if ([options[@"sourceNames"] isKindOfClass:[NSArray class]]) {
        NSArray *optSources = options[@"sourceNames"];
        NSMutableArray *sourceNames = [NSMutableArray array];

        for (NSString *source in optSources) {
            NSString *addSource = nil;
            if ([source isEqualToString:@"FPSourceBox"])
                addSource = FPSourceBox;
            else if ([source isEqualToString:@"FPSourceCameraRoll"])
                addSource = FPSourceCameraRoll;
            else if ([source isEqualToString:@"FPSourceDropbox"])
                addSource = FPSourceDropbox;
            else if ([source isEqualToString:@"FPSourceFacebook"])
                addSource = FPSourceFacebook;
            else if ([source isEqualToString:@"FPSourceGithub"])
                addSource = FPSourceGithub;
            else if ([source isEqualToString:@"FPSourceGmail"])
                addSource = FPSourceGmail;
            else if ([source isEqualToString:@"FPSourceImagesearch"])
                addSource = FPSourceImagesearch;
            else if ([source isEqualToString:@"FPSourceCamera"])
                addSource = FPSourceCamera;
            else if ([source isEqualToString:@"FPSourceGoogleDrive"])
                addSource = FPSourceGoogleDrive;
            else if ([source isEqualToString:@"FPSourceInstagram"])
                addSource = FPSourceInstagram;
            else if ([source isEqualToString:@"FPSourceFlickr"])
                addSource = FPSourceFlickr;
            else if ([source isEqualToString:@"FPSourcePicasa"])
                addSource = FPSourcePicasa;
            else if ([source isEqualToString:@"FPSourceSkydrive"])
                addSource = FPSourceSkydrive;
            else if ([source isEqualToString:@"FPSourceEvernote"])
                addSource = FPSourceEvernote;

            if (addSource)
                [sourceNames addObject:addSource];
        }

        fpController.sourceNames = sourceNames;
    }

    [self.viewController presentModalViewController:fpController animated:YES];
}

- (void)FPPickerController:(FPPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

    NSDictionary *dict = @{@"url": info[@"FPPickerControllerRemoteURL"],
                           @"mediatype": info[@"FPPickerControllerMediaType"],
                           @"localUrl": [(NSURL*)info[@"FPPickerControllerMediaURL"] absoluteString],
                           @"filename": info[@"FPPickerControllerFilename"]};

    // Fire the JS callback
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)FPPickerControllerDidCancel:(FPPickerController *)picker
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

    // Fire the JS callback
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{ @"code": @101 }];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
};

@end
