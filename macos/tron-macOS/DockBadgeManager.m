#import "NotificationManager.h"
#import "Notification.h"
#import <React/RCTBridge.h>

@implementation NotificationManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setBadge)
{
  NSApp.dockTile.badgeLabel = @"•";
}
RCT_EXPORT_METHOD(clearBadge)
{
  NSApp.dockTile.badgeLabel = nil;
}