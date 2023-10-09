//
//  SwiftUIHostingController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 28/09/23.
//

import Foundation
import UIKit
import SwiftUI

class SwiftUIHostingController: UIHostingController<CalculateView> {
    override init(rootView: CalculateView) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
