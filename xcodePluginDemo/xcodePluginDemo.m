//
//  xcodePluginDemo.m
//  xcodePluginDemo
//
//  Created by wangyang on 5/21/15.
//  Copyright (c) 2015 com.wy. All rights reserved.
//

#import "xcodePluginDemo.h"
#import "NSView+dump.h"

static xcodePluginDemo *sharedPlugin;

@interface xcodePluginDemo()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation xcodePluginDemo

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}


- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
 
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
       
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification*)noti {
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *deumpWindowItem = [[NSMenuItem alloc] initWithTitle:@"dump current window" action:@selector(doMenuAction) keyEquivalent:@"V"];
        [deumpWindowItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [deumpWindowItem setTarget:self];
        [[menuItem submenu] addItem:deumpWindowItem];
        
        NSMenuItem *dumpSheetItem = [[NSMenuItem alloc] initWithTitle:@"dump sheets" action:@selector(dumpSheets) keyEquivalent:@"S"];
        [dumpSheetItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [dumpSheetItem setTarget:self];
        [[menuItem submenu] addItem:dumpSheetItem];
    }
    
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    [[[NSApp mainWindow] contentView] dumpWithIndent:@""];
    
}

- (void)dumpSheets{
    [[[NSApp mainWindow] contentView] dumpSheets];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
