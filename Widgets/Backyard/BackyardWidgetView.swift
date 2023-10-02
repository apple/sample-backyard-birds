/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The backyard widget view.
*/

import SwiftUI
import WidgetKit
import BackyardBirdsData
import BackyardBirdsUI
import LayeredArtworkLibrary

struct BackyardWidgetView: View {
    var entry: BackyardWidgetEntry
    
    var body: some View {
        if let snapshot = entry.snapshot {
            BackyardSnapshotWidgetView(snapshot: snapshot)
        } else {
            Text("No Backyards")
                .foregroundStyle(.secondary)
                .containerBackground(.fill, for: .widget)
        }
    }
    
}

struct BackyardSnapshotWidgetView: View {
    var snapshot: BackyardSnapshot
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.widgetRenderingMode) private var widgetRenderingMode
    
    var hasVisitingBird: Bool {
        snapshot.visitingBird != nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            Spacer()
            
            birdView
            
            if snapshot.notableEvents.contains(.lowSupplySeverityIncrease) {
                suppliesLowDetail
            } else if snapshot.notableEvents.contains(.visitorArrive) {
                arrivalMessage
            } else {
                gauges
            }
        }
        .environment(\.colorScheme, snapshot.timeOfDay.colorSchemeOverride ?? colorScheme)
        .containerBackground(for: .widget) {
            BackyardSkyView(timeInterval: snapshot.timeInterval)
                .opacity(colorScheme == .dark ? 0.75 : 1)
        }
    }
    
    @ViewBuilder
    var header: some View {
        HStack(spacing: 4) {
            Image.fountainFill
            Text(snapshot.backyard.name)
            Spacer()
            snapshot.timeOfDay.view
                .imageScale(.large)
                .symbolVariant(.fill)
                .transition(.scale.combined(with: .opacity))
        }
        .font(.caption)
        .foregroundStyle(.secondary.vibrantlyBlended)
        .environment(\.backgroundMaterial, .regular)
    }
    
    @ViewBuilder
    var birdView: some View {
        if let bird = snapshot.visitingBird {
            ZStack {
                if widgetRenderingMode == .fullColor {
                    ComposedBird(bird: bird)
                } else {
                    VibrantBird(bird: bird)
                }
            }
            .id(bird.id)
            .transition(
                .asymmetric(
                    insertion: .offset(x: 100),
                    removal: .offset(x: -100)
                )
                .combined(with: .scale(scale: 0.7))
                .combined(with: .opacity)
            )
        }
    }
    
    @ViewBuilder
    var arrivalMessage: some View {
        if let visitingBird = snapshot.visitingBird {
            HStack {
                VStack(alignment: .leading) {
                    Text(visitingBird.speciesName)
                        .font(.subheadline.bold())
                    Text("Arrived \(Duration.seconds(4 * 60).formatted(Self.remainingMinutesFormatter)) ago",
                         comment: "The variable is formatted as minutes.")
                        .foregroundStyle(.secondary.vibrantlyBlended)
                        .font(.footnote)
                }
                
                Spacer()
            }
            .font(.caption)
            .transition(.offset(y: 50).combined(with: .scale(scale: 0.9)).combined(with: .opacity))
        }
    }
    
    @ViewBuilder
    var suppliesLowDetail: some View {
        VStack(alignment: .leading) {
            if hasVisitingBird {
                HStack {
                    lowWaterIndicator
                        .imageScale(.large)
                    Text("Water Low · \(Duration.seconds(59 * 60).formatted(Self.remainingMinutesFormatter))",
                         comment: "The variable is formatted as minutes.")
                        .foregroundStyle(.tertiary.vibrantlyBlended)
                        .font(.footnote)
                    Spacer()
                }
            } else {
                VStack(alignment: .leading) {
                    lowWaterIndicator
                        .imageScale(.large)
                        .font(.title2)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Water Low")
                                .font(.headline.bold())
                            Text("\(Duration.seconds(59 * 60).formatted(Self.remainingMinutesFormatter)) remaining",
                                 comment: "The variable is formatted as minutes.")
                                .foregroundStyle(.tertiary.vibrantlyBlended)
                                .font(.footnote)
                        }
                        Spacer()
                    }
                }
            }
            Button(intent: ResupplyBackyardIntent(backyard: BackyardEntity(from: snapshot.backyard))) {
                Label("Refill Water", systemImage: "arrow.clockwise")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(.quaternary, in: .containerRelative)
            }
            .font(.subheadline)
            .buttonStyle(.plain)
            .transition(.scale.combined(with: .opacity))
        }
        .font(.caption)
        .environment(\.backgroundMaterial, .regular)
    }
    
    var lowWaterIndicator: some View {
        Image(systemName: "drop.triangle.fill")
            .foregroundStyle(.primary.opacity(0.4).vibrantlyBlended, .quaternary)
            .symbolRenderingMode(.palette)
            .transition(.scale.combined(with: .opacity))
    }
    
    var gauges: some View {
        Grid {
            GridRow {
                Image(systemName: "drop.fill")
                    .foregroundStyle(.secondary.vibrantlyBlended)
                
                Text(Duration.seconds(60 * 60 * 5), format: Self.remainingHoursFormatter)
                    .foregroundStyle(.secondary.vibrantlyBlended)
                
                Gauge(value: 0.6) {
                    EmptyView()
                }
                .tint(Gradient(colors: [.mint, .cyan]))
                .labelsHidden()
            }
            
            GridRow {
                Image(systemName: "fork.knife")
                    .foregroundStyle(.secondary.vibrantlyBlended)
                
                Text(Duration.seconds(60 * 60 * 3), format: Self.remainingHoursFormatter)
                    .foregroundStyle(.secondary.vibrantlyBlended)
                
                Gauge(value: 0.4) {
                    EmptyView()
                }
                .tint(Gradient(colors: [.red, .orange]))
                .labelsHidden()
            }
        }
        .font(.caption)
    }
    
    private static let remainingMinutesFormatter = Duration.UnitsFormatStyle(allowedUnits: [.minutes], width: .condensedAbbreviated)
    private static let remainingHoursFormatter = Duration.UnitsFormatStyle(allowedUnits: [.hours], width: .condensedAbbreviated)
}
