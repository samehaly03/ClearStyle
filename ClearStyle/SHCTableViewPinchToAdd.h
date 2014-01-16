#import "SHCTableView.h"

// A behavior that adds the facility to pinch the list in order to insert a new
// item at any location.
@interface SHCTableViewPinchToAdd : NSObject

// associates this behavior with the given table
-(id)initWithTableView:(SHCTableView*)tableView;

@end