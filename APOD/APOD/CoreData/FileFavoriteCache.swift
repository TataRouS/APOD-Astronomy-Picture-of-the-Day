//
//  FileFavoriteCache.swift
//  APOD
//
//  Created by Nata Kuznetsova on 29.11.2023.
//

import Foundation
import CoreData

protocol FileCacheProtocol {
    func save()
    func delete(object: NSManagedObject)
    func addPicture (apod: DataImage)
    func fetchPictures() -> [DataImage]
}

final class FileFavoriteCache: FileCacheProtocol {
   
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "APODDataModel")
        persistentContainer.loadPersistentStores(completionHandler: {(_, error)
            in
            if let error = error {
                print(error)
            }
        })
        return persistentContainer
    }()
    
    func save(){
        if persistentContainer.viewContext.hasChanges{
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(object: NSManagedObject){
        persistentContainer.viewContext.delete(object)
        save()
    }
    
    func addPicture (apod: DataImage) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PictureModelCD")
        fetchRequest.predicate = NSPredicate(format: "date = %@", argumentArray: [apod.date ?? ""])
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
        guard result?.first == nil else {
            return
        }
        let apodModel = PictureModelCD(context: persistentContainer.viewContext)
        apodModel.title = apod.title
        apodModel.explanation = apod.explanation
        apodModel.picture = apod.hdurl
        apodModel.date = apod.date
        
        save()
    }
    
    func fetchPictures() -> [DataImage] {
        let fetchRequest: NSFetchRequest<PictureModelCD> =
        PictureModelCD.fetchRequest()
        guard let apods = try?
                persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var favoriteApods: [DataImage] = []
        for apod in apods {
            favoriteApods.append(DataImage (date: apod.date,
                                            explanation: apod.explanation,
                                            hdurl: apod.picture,
                                            title: apod.title
                                           ))
        }
        return favoriteApods
    }
}
