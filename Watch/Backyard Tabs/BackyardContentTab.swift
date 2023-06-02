/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard content tab.
*/

import SwiftUI
import BackyardBirdsData

struct BackyardContentTab: View {
    var backyard: Backyard
    @State private var presentingBirdFoodPicker = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Label("Food is running low", systemImage: "fork.knife")
            Label("Water is okay", systemImage: "cup.and.saucer.fill")

            Button("Refill") {
                presentingBirdFoodPicker = true
            }
            
            Spacer()
        }
        .containerBackground(.green.gradient, for: .tabView)
        .navigationTitle("Amenities")
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Gauge(value: 0.5) {
                    Label("Water", systemImage: "cup.and.saucer.fill")
                } currentValueLabel: {
                    Text(Duration.seconds(60 * (59 + 4 * 60)), format: timeFormatter)
                }
                .tint(Gradient(colors: [.blue, .green]))
                .gaugeStyle(.accessoryCircularCapacity)
                
                Gauge(value: 0.25) {
                    Label("Food", systemImage: "fork.knife")
                } currentValueLabel: {
                    Text(Duration.seconds(60 * (59 + 6 * 60)), format: timeFormatter)
                }
                .tint(Gradient(colors: [.yellow, .orange]))
                .gaugeStyle(.accessoryCircularCapacity)
            }
        }
        .sheet(isPresented: $presentingBirdFoodPicker) {
            BirdFoodPickerSheet(backyard: backyard)
        }
    }
    
    let timeFormatter: Duration.TimeFormatStyle = Duration.TimeFormatStyle(pattern: .hourMinute)
}
