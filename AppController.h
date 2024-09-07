/* 
   Project: TestDocument

   Author: Sebastian Reitenbach

   Created: 2024-09-02 20:08:03 +0200 by sebastia
   
   Application Controller
*/
 
#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <AppKit/AppKit.h>

@interface AppController : NSObject
{
}

+ (void)  initialize;

- (id) init;
- (void) dealloc;

- (void) showPrefPanel: (id)sender;

// called by the AppDelegate on startup
- (void)setupApplication;

@end

#endif
