/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The generation data.
*/

import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "DataGeneration")

// MARK: - Data Generation

@Model public class DataGeneration {
    public var initializationDate: Date?
    public var lastSimulationDate: Date?
    
    @Transient public var includeEarlyAccessSpecies: Bool = false
    
    public var requiresInitialDataGeneration: Bool {
        initializationDate == nil
    }
    
    public init(initializationDate: Date?, lastSimulationDate: Date?, includeEarlyAccessSpecies: Bool = false) {
        self.initializationDate = initializationDate
        self.lastSimulationDate = lastSimulationDate
        self.includeEarlyAccessSpecies = includeEarlyAccessSpecies
    }
    
    private func simulateHistoricalEvents(modelContext: ModelContext) {
        logger.info("Attempting to simulate historical events...")
        if requiresInitialDataGeneration {
            logger.info("Requires an initial data generation")
            generateInitialData(modelContext: modelContext)
        }
    }
    
    private func generateInitialData(modelContext: ModelContext) {
        logger.info("Generating initial data...")
        
        // First, generate all available bird food, bird species, and plant species.
        logger.info("Generating all bird foods")
        BirdFood.generateAll(modelContext: modelContext)
        logger.info("Generating all bird species")
        BirdSpecies.generateAll(modelContext: modelContext)
        logger.info("Generating plant species")
        PlantSpecies.generateAll(modelContext: modelContext)
        
        // Then, generate instances of individual plants not tied to any backyards, all of the birds,
        // and finally the backyards themselves (with their own plants).
        logger.info("Generating initial instances of individual plants")
        Plant.generateIndividualPlants(modelContext: modelContext)
        logger.info("Generating initial instances of all birds")
        Bird.generateAll(modelContext: modelContext)
        logger.info("Generating initial instances of backyards")
        Backyard.generateAll(modelContext: modelContext)
        
        logger.info("Generating account")
        // The app content is complete, now it's time to create the person's account.
        Account.generateAccount(modelContext: modelContext)
        
        logger.info("Completed generating initial data")
        initializationDate = .now
    }
    
    private func generateVisitorEvents(modelContext: ModelContext, includeEarlyAccessSpecies: Bool = false) {
        guard lastSimulationDate == nil else {
            return
        }
        logger.info("Generating visitor events")
        BackyardVisitorEvent.generateHistoricalEvents(
            modelContext: modelContext,
            includeEarlyAccessSpecies: includeEarlyAccessSpecies
        )
        BackyardVisitorEvent.generateCurrentEvents(
            modelContext: modelContext,
            includeEarlyAccessSpecies: includeEarlyAccessSpecies
        )
        BackyardVisitorEvent.generateFutureEvents(
            modelContext: modelContext,
            includeEarlyAccessSpecies: includeEarlyAccessSpecies
        )
        lastSimulationDate = .now
    }

    private static func instance(with modelContext: ModelContext) -> DataGeneration {
        if let result = try! modelContext.fetch(FetchDescriptor<DataGeneration>()).first {
            return result
        } else {
            let instance = DataGeneration(
                initializationDate: nil,
                lastSimulationDate: nil
            )
            modelContext.insert(instance)
            return instance
        }
    }
    
    public static func generateAllData(modelContext: ModelContext) {
        let instance = instance(with: modelContext)
        logger.info("Attempting to statically simulate historical events...")
        instance.simulateHistoricalEvents(modelContext: modelContext)
    }
    
    public static func generateVisitorEvents(modelContext: ModelContext, includeEarlyAccessSpecies: Bool = false) {
        let instance = instance(with: modelContext)
        instance.generateVisitorEvents(
            modelContext: modelContext,
            includeEarlyAccessSpecies: includeEarlyAccessSpecies
        )
    }
    
}

public extension DataGeneration {
    static let container = try! ModelContainer(for: schema, configurations: [.init(isStoredInMemoryOnly: DataGenerationOptions.inMemoryPersistence)])
    
    static let schema = SwiftData.Schema([
        DataGeneration.self,
        Account.self,
        PlantSpecies.self,
        Plant.self,
        BirdSpecies.self,
        BirdFood.self,
        Bird.self,
        Backyard.self,
        BackyardVisitorEvent.self
    ])
}
