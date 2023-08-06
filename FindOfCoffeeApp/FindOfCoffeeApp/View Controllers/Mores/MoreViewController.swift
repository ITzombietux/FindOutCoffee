//
//  MoreViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/17.
//

import UIKit
import SafariServices

class MoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.4)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = .label
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let articleStr = "https://velog.io/@architecture/개인정보처리방침-t22k6wps"
                
                let articleURLStr = articleStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                guard let url = URL(string: articleURLStr) else { return }
                
                
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let safari = SFSafariViewController(url: url, configuration: config)
                
                safari.preferredBarTintColor = UIColor.systemGray5.withAlphaComponent(0.85)
                safari.preferredControlTintColor = UIColor.systemBlue
                
                present(safari, animated: true, completion: nil)
            }
        }
    }
}
