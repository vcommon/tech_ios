//
//  SwiftViewController.swift
//  tech_ios
//
//  Created by peter on 2018/1/31.
//  Copyright © 2018年 peter. All rights reserved.
//

import Foundation
import UIKit

@objc class SwiftViewController : UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad();
        let itemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(sayHello(sender:)))
        self.navigationController?.navigationItem.rightBarButtonItem = itemDone;
    }
    func sayHello(sender: UIBarButtonItem) {
        let vc = NavTechViewController.init();
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
