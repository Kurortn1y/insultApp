//
//  InsultViewController.swift
//  insultApp
//
//  Created by Roman on 15.11.23.
//

import UIKit

class InsultViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var insultLabel: UILabel!
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    func fetchInsult() {
        
        var request = URLRequest(url: insultURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        networkManager.fetch(type: Insult.self, request: request) {[unowned self] result in
            switch result {
                
            case .success(let success):
                          
                configure(with: success)
                print(success)
            case .failure(let failed):
                print(failed)
            }
        }
        
    }
    
    private func configure(with insult: Insult) {
        insultLabel.text = insult.insult
        activityIndicator.stopAnimating()
    }
    

}
