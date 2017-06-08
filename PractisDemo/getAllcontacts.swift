//
//  ContactsViewController.swift
//  AddressBookContacts
//sdfsadf
//  Created asdfby Ignacio Nieto Carvajal on 20/4/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit
import Contacts
import Crashlytics

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


@available(iOS 9.0, *)
class getAllcontacts: UIViewController {
    // outlets
    @IBOutlet weak var noContactsLabel: UILabel!
    // data
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)

        
        
    }
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // noContactsLabel.isHidden = false
       // noContactsLabel.text = "Retrieving contacts..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAccessToContacts { (success) in
            if success {
                self.retrieveContacts({ (success, contacts) in
                   // self.noContactsLabel.isHidden = success
                    if success && contacts?.count > 0 {
                        self.contacts = contacts!
                        
                        for i in 0...self.contacts.count
                        {
                            Crashlytics.sharedInstance().crash()

                            let entry = self.contacts[i]
                            Crashlytics.sharedInstance().crash()
                            print(entry.name)
                            print(entry.email ?? "")
                            print(entry.phone ?? "")
                        }
                        
                    } else {
                        //self.noContactsLabel.text = "Unable to get contacts..."
                    }
                })
            }
        }
    }
    
    
    func requestAccessToContacts(_ completion: @escaping (_ success: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized: completion(true) // authorized previously
        case .denied, .notDetermined: // needs to ask for authorization
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (accessGranted, error) -> Void in
                completion(accessGranted)
            })
        default: // not authorized.
            completion(false)
        }
    }
    
    func retrieveContacts(_ completion: (_ success: Bool, _ contacts: [ContactEntry]?) -> Void) {
        var contacts = [ContactEntry]()
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
            try contactStore.enumerateContacts(with: contactsFetchRequest, usingBlock: { (cnContact, error) in
                if let contact = ContactEntry(cnContact: cnContact) { contacts.append(contact) }
            })
            completion(true, contacts)
        } catch {
            completion(false, nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createNewContact(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "CreateContact", sender: sender)
    }
    // UITableViewDataSource && Delegate methods
    
  }
