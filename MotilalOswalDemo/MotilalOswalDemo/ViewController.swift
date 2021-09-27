//
//  ViewController.swift
//  MotilalOswalDemo
//
//  Created by yash on 22/09/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    var categories = [Category]()
    var items = [Item]()
    var persons = [Person]()
    var textField = UITextField()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCategory()
        self.loadItems()
        self.loadPersons()
        setNavBar()
    }
    
    func setNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 50))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "ToDoList App");
        navBar.setItems([navItem], animated: true);
    }
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        toDoTableView.reloadData()
    }
    
    func loadCategory(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print(error)
        }
        toDoTableView.reloadData()
    }
    
    func loadItems(request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            items = try context.fetch(request)
        } catch {
            print(error)
        }
        toDoTableView.reloadData()
    }
    
    func loadPersons(request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            items = try context.fetch(request)
        } catch {
            print(error)
        }
        toDoTableView.reloadData()
    }
    
   
    
}

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        }
        if section == 1 {
            return items.count
        }
        if section == 2 {
            return persons.count
        }
        return 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = categories[indexPath.row].name
        case 1:
            cell.textLabel?.text = items[indexPath.row].content
        case 2:
            cell.textLabel?.text = persons[indexPath.row].city
        default:
            break
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(categories.count)
        switch (indexPath.section) {
        
        case 0:
            let item = categories[indexPath.row]
            context.delete(item)
            saveCategories()
            categories.remove(at: indexPath.row)
            
        case 1:
            let itemss = items[indexPath.row]
            context.delete(itemss)
            saveCategories()
            items.remove(at: indexPath.row)
            
        case 2:
            let person = persons[indexPath.row]
            context.delete(person)
            saveCategories()
            persons.remove(at: indexPath.row)
        default:
            break
        }
        
        toDoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = tableView.frame
        let toDoTaskLabel = UILabel(frame: CGRect(x: 20, y: 30, width: 100, height: 50))
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 45, width: 15, height: 20))
        
        if section == 0 {
            toDoTaskLabel.text = "Today"
            button.addTarget(self,action:#selector(todaybuttonClicked),for:.touchUpInside)
            
            
        }
        if section == 1 {
            toDoTaskLabel.text = "Tommorow"
            button.addTarget(self,action:#selector(tommowbuttonClickeds),for:.touchUpInside)
            
        }
        if section == 2 {
            toDoTaskLabel.text = "Upcoming"
            button.addTarget(self,action:#selector(upcomingbuttonClickeds),for:.touchUpInside)
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        button.setImage(UIImage(named: "icons8-add-24"), for: UIControl.State.normal)
        headerView.addSubview(button)
        headerView.addSubview(toDoTaskLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    @objc func todaybuttonClicked(sender:UIButton)
    {
        let alert = UIAlertController(title: "New Item", message: "Add new item to list.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Now", style: .default) { [self] (action) in
            let newCategory = Category(context: context)
            newCategory.name = textField.text!
            categories.append(newCategory)
            saveCategories()
        }
        
        alert.addTextField { (text) in
            self.textField = text
            self.textField.autocapitalizationType = .words
        }
        
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tommowbuttonClickeds(sender:UIButton)
    {
        let alert = UIAlertController(title: "New Item", message: "Add new item to list.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Now", style: .default) { [self] (action) in
            let newItem = Item(context: context)
            newItem.content = textField.text!
            items.append(newItem)
            saveCategories()
        }
        
        alert.addTextField { (text) in
            self.textField = text
            self.textField.autocapitalizationType = .words
        }
        
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func upcomingbuttonClickeds(sender:UIButton)
    {
        let alert = UIAlertController(title: "New Item", message: "Add new item to list.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Now", style: .default) { [self] (action) in
            let newPerson = Person(context: context)
            newPerson.city = textField.text!
            persons.append(newPerson)
            
            saveCategories()
        }
        
        alert.addTextField { (text) in
            self.textField = text
            self.textField.autocapitalizationType = .words
        }
        
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
