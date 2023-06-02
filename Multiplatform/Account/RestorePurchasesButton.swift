/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The restore purchases button.
*/

import SwiftUI
import StoreKit

struct RestorePurchasesButton: View {
    @State private var isRestoring = false
    
    var body: some View {
        Button("Restore Purchases") {
            isRestoring = true
            Task.detached {
                defer { isRestoring = false }
                try await AppStore.sync()
            }
        }
        .disabled(isRestoring)
    }
    
}

#Preview {
    RestorePurchasesButton()
}
