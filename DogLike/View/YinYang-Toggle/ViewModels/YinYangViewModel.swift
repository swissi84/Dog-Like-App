

import SwiftUI

@Observable
class YinYangViewModel {
    
    // MARK: - Variables
    var forTest = false
    var themeToggled: Bool = false

    
    // MARK: - Inits
    init(forTest: Bool = false) {
        self.forTest = forTest
    }
    
    
    // MARK: - Functions
}
