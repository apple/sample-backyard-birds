/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The navigation stack holding the account view.
*/

import SwiftUI
import SwiftData
import BackyardBirdsUI
import LayeredArtworkLibrary
import BackyardBirdsData

struct AccountNavigationStack: View {
    @Query
    private var accounts: [Account]
    
    @Environment(\.passStatus) private var passStatus
    @Environment(\.passIDs.group) private var passGroupID
    
    @State private var presentingPassSheet = false
    @State private var presentingEditAccountSheet = false
    
    #if os(iOS)
    @State private var presentingManagePassSheet = false
    #elseif os(macOS)
    @Environment(\.openURL) private var openURL
    #endif
    
    var body: some View {
        NavigationStack {
            if let account = accounts.first, let bird = accounts.first?.bird {
                Form {
                    VStack {
                        BirdIcon(bird: bird)
                            .frame(width: 80, height: 80)
                        
                        Text(account.displayName)
                            .font(.headline.bold())
                            .overlay(alignment: .leading) {
                                (account.isPremiumMember ? Label("Premium Member", systemImage: "bird.fill") :
                                    Label("Standard Member", systemImage: "bird"))
                                .foregroundStyle(.tint)
                                .labelStyle(.iconOnly)
                                .imageScale(.large)
                                .alignmentGuide(.leading) { $0[.trailing] + 4 }
                            }
                        
                        Text("Joined \(account.joinDate.formatted(.dateTime.month(.wide).day(.twoDigits).year()))",
                             comment: "Variable is the calendar date when the person joined.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                    
                    Section {
                        if passStatus == .individual || passStatus == .family {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("""
                                Unlock the complete backyard experience with early \
                                access to new bird species and more!
                                """)
                                Button("Check out Premium \(Image(systemName: "chevron.forward"))") {
                                    presentingPassSheet = true
                                }
                                .font(.callout)
                                .buttonStyle(.borderless)
                            }
                        }
                        if case .notSubscribed = passStatus {
                            Button {
                                presentingPassSheet = true
                            } label: {
                                Label("Get Backyard Birds Pass", systemImage: "wallet.pass")
                                    #if os(macOS)
                                    .labelStyle(.titleOnly)
                                    #endif
                            }
                        } else {
                            Button {
                            #if os(iOS)
                                presentingManagePassSheet = true
                            #elseif os(macOS)
                                openURL(URL(string: "https://apps.apple.com/account/subscriptions")!)
                            #endif
                            } label: {
                                manageSubscriptionLabel
                            }
                        }
                    } footer: {
                        if passStatus != .notSubscribed {
                            Text("Backyard Birds Pass: \(String(describing: passStatus))")
                        }
                    }
                    .symbolVariant(.fill)
                    Section {
                        RestorePurchasesButton()
                    }
                }
                .formStyle(.grouped)
                .navigationTitle("Account")
                .toolbar {
                    Button {
                        presentingEditAccountSheet = true
                    } label: {
                        Label("Edit Account", systemImage: "pencil")
                    }
                }
                .sheet(isPresented: $presentingEditAccountSheet) {
                    EditAccountForm(account: account)
                }
                .sheet(isPresented: $presentingPassSheet) {
                    BackyardBirdsPassShop()
                }
                #if os(iOS)
                .manageSubscriptionsSheet(
                    isPresented: $presentingManagePassSheet,
                    subscriptionGroupID: passGroupID
                )
                #endif
            } else {
                ContentUnavailableView("No Account Found", systemImage: "bird")
            }
        }
    }
    
    @ViewBuilder
    private var manageSubscriptionLabel: some View {
        Label {
            Text("Your Backyard Birds Pass: \(String(describing: passStatus))",
                 comment: "The variable is the type of Backyard Birds Pass (such as Premium, Family, and so on.)")
        } icon: {
            Image(systemName: "wallet.pass")
        }
        #if os(macOS)
        .labelStyle(.titleOnly)
        #endif
    }
    
}

#Preview {
    AccountNavigationStack()
        .backyardBirdsDataContainer(inMemory: true)
}
