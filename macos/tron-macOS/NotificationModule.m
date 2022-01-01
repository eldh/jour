#import "NotificationModule.h"
@implementation NotificationModule

// To export a module named DockBadge
RCT_EXPORT_MODULE(Notification);
RCT_EXPORT_METHOD(sendNotification :(NSString *)title :(NSString *)subtitle)
{
  NSUserNotification *notification = [[NSUserNotification alloc] init];
      notification.title = title;
      notification.informativeText = [NSString stringWithFormat:subtitle];
      notification.soundName = NSUserNotificationDefaultSoundName;
      [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

}
@end
