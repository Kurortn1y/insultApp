//
//  ViewController.swift
//  insultApp
//
//  Created by Roman on 12.11.23.
//

import UIKit

final class StartViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  let insultVC = segue.destination as? InsultViewController else { return }
        insultVC.fetchInsult()
    }
    override func viewDidLoad() {
        view.backgroundColor = .cyan
    }
    @IBAction func getInsultButtonTapped() {
        
    }
    
}
