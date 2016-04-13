import UIKit
import CoreData

class MasterViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func filterForIndexPath(indexPath: NSIndexPath) -> NSPredicate? {
        var filter: NSPredicate? = nil
        switch indexPath.row {
        case 0:
            filter = nil
            break
        case 1:
            filter = NSPredicate(format:"checked = true")
            break
        case 2:
            let request = NSFetchRequest()
            request.entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: self.managedObjectContext!)
            request.predicate = NSPredicate(format: "checked = true")
            request.resultType = .ManagedObjectIDResultType
            do {
                let items = try self.managedObjectContext?.executeFetchRequest(request) as! [NSManagedObject]
                filter = NSPredicate(format: "self in %@", items)
            } catch {
                self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
            break
        default:
            self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
        return filter;
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filter = self.filterForIndexPath(indexPath)
        let nextViewController = FetchedResultsViewController.init(filter:filter)
        nextViewController.managedObjectContext = self.managedObjectContext
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        cell.textLabel!.text = ["All", "Checked(Dynamic)", "Checked(Static)"][indexPath.row]
    }
}

