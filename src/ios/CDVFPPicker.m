
#import <FPPicker/FPPicker.h>

@implementation CDVFPPicker

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

    self.callbackId = command.callbackId;
    NSDictionary *options = [command.arguments objectAtIndex:0];

    if (options[@"allowsEditing"] != nil) {
      fpController.allowsEditing = options[@"allowsEditing"];
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

    // Fire the JS callback
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:info];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

@end
