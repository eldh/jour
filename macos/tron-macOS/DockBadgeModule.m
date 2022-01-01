#import "DockBadgeModule.h"

@implementation DockBadgeModule

// To export a module named DockBadge
RCT_EXPORT_MODULE(DockBadge);
RCT_EXPORT_METHOD(setBadge :(NSString *)content)
{
  NSApp.dockTile.badgeLabel = content;
}
RCT_EXPORT_METHOD(clearBadge)
{
  NSApp.dockTile.badgeLabel = nil;
}
@end
