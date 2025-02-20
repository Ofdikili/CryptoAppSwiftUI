//
//  PortfolioDataService.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 19.02.2025.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedEnities: [PortfolioEntity] = []
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.getPortfolio()
        }
    }
    
    public func updatePortfolio(coin : CoinModel , amount : Double){
        if let entity =  savedEnities.first(where: {$0.coinID == coin.id}){
            if(entity.amount>0){
                update(entity: entity, amount: amount)
            }else{
                remove(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do{
          savedEnities =  try container.viewContext.fetch(request)
        }catch let error as NSError{
            print("Error fetcing Portfolio: \(error)")
        }
    }
    
    private func add(coin : CoinModel , amount : Double) {
      let entity = PortfolioEntity(context: container.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
        
    }
    
    private func update(entity : PortfolioEntity , amount : Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        }catch let error as NSError{
                print("Error saving Portfolio: \(error)")
        }
    }
    
    private func applyChanges(){
        save( )
        getPortfolio()
    }
}
