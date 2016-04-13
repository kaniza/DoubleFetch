import Foundation
import CoreData

class Item: NSManagedObject {
    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.checked = NSNumber.init(booleanLiteral: false)
    }
}
