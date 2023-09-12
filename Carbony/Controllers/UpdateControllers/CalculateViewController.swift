//
//  CalculateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 05/09/23.
//

import UIKit

class CalculateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Calculate Footprint"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupCancelButton()
    }
    
    private func setupCancelButton() {
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonAction))
        self.navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    @objc private func cancelBarButtonAction() {
        self.dismiss(animated: true)
    }
}
