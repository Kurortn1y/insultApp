//
//  ViewController.swift
//  insultApp
//
//  Created by Roman on 12.11.23.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBAction func getInsult() {
        fetchInsult()
    }
}

extension ViewController {
    private func fetchInsult() {
        
        let insultUrl = URL(string: "https://evilinsult.com/generate_insult.php?lang=en&type=json")!
        
        URLSession.shared.dataTask(with: insultUrl) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? " No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let insult = try decoder.decode(Insult.self, from: data)
                print(insult)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
// Постоянно выдает одно и тоже оскорбление ,так и не понял с чем это связанно , пытался с классом многопоточности - тоже самое.
