/* 
   Project: TestDocument

   Author: Sebastian Reitenbach

   Created: 2024-09-02 20:08:03 +0200 by sebastia
*/

#import <AppKit/AppKit.h>
#import "CustomInitializer.h"

int 
main(int argc, const char *argv[])
{
  @autoreleasepool
    {
      [CustomInitializer initializeCustomDocumentController];
      return NSApplicationMain (argc, argv);
    }
}

