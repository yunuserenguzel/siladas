//
//  ViewController.swift
//  Siladas
//
//  Created by Yunus Güzel on 11.12.19.
//  Copyright © 2019 Yunus Güzel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var userNameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userNameLabel.text = Services.shared.firebaseConnector.userId
    
  }
}

