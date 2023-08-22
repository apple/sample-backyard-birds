/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard supply indicator view.
*/

import SwiftUI
import BackyardBirdsUI
import BackyardBirdsData

struct BackyardSupplyIndicator: View {
    var backyard: Backyard
    var supplies: BackyardSupplies
    
    @State private var presentingBirdFoodPicker = false
    
    var body: some View {
        Button {
            switch supplies {
            case .food:
                presentingBirdFoodPicker = true
            case .water:
                withAnimation {
                    backyard.waterRefillDate = .now
                }
            }
        } label: {
            HStack {
                BackyardSupplyGauge(backyard: backyard, supplies: supplies)
                    .controlSize(.large)
                
                VStack(alignment: .leading) {
                    switch supplies {
                    case .food:
                        Text(backyard.birdFood?.name ?? "- Food name is missing. -")
                    case .water:
                        Text("Water", comment: "Shown in the context of food supplies in a given backyard")
                    }
                    Text(
                        "\(formattedTimeRemaining(from: secondsRemaining)) remaining",
                         comment: "Used to indicate remaining time. Variable is formatted in hours/minutes (e.g. “1h” or “33mn”.)"
                    )
                    .foregroundStyle(.secondary)
                    .font(.callout)
                    .lineLimit(1)
                }
                
                Spacer()
                
                HStack {
                    switch supplies {
                    case .food:
                        Label("Choose Food", systemImage: "arrow.left.arrow.right")
                    case .water:
                        Label("Refill Water", systemImage: "arrow.clockwise")
                    }
                }
                .foregroundStyle(.secondary)
                .frame(width: 44)
                .labelStyle(.iconOnly)
            }
            .padding(12)
            .background(.fill.tertiary)
            .contentShape(.containerRelative)
            .containerShape(.rect(cornerRadius: 20))
            #if !os(macOS)
            .hoverEffect(.highlight)
            #endif
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $presentingBirdFoodPicker) {
            BirdFoodPickerSheet(backyard: backyard)
            #if os(macOS)
                .frame(minWidth: 520, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            #endif
        }
    }

    func formattedTimeRemaining(from timeInterval: TimeInterval) -> String {
        // In this context, we're only looking at the second at most, so it's fine if we round by the second
        let duration = Duration(secondsComponent: Int64(timeInterval), attosecondsComponent: 0)
        return duration.formatted(.units(allowed: [.hours, .minutes, .seconds], width: .abbreviated, maximumUnitCount: 1))
    }
    
    var secondsRemaining: TimeInterval {
        max(Date.now.distance(to: backyard.expectedEmptyDate(for: supplies)), 0)
    }
}

#Preview {
    ModelPreview { backyard in
        BackyardSupplyIndicator(backyard: backyard, supplies: .food)
    }
}
