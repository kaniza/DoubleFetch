import Foundation
import CoreData

extension Item {

    @NSManaged var timeStamp: NSDate?
    @NSManaged var title: String?
    @NSManaged var checked: NSNumber?

}
