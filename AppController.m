/* 
   Project: TestDocument

   Author: Sebastian Reitenbach

   Created: 2024-09-02 20:08:03 +0200 by sebastia
   
   Application Controller
*/

#import "AppController.h"
#import "TestWindowController.h"
#import "TestDocumentController.h"

@implementation AppController

+ (void) initialize
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  /*
   * Register your app's defaults here by adding objects to the
   * dictionary, eg
   *
   * [defaults setObject:anObject forKey:keyForThatObject];
   *
   */
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init
{
  if ((self = [super init]))
    {
    }
  return self;
}

- (void) dealloc
{
}


- (void) showPrefPanel: (id)sender
{
  NSLog(@"AppController: showPrefPanel: was called");
}

- (void)setupApplication
{
  // Setup global settings, preferences, or shared resources here
  NSLog(@"AppController: setupApplication was called");
}


@end
