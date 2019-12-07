//
//  SearchViewModel.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 03/12/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

enum ViewMode: String {
    case search = "Search"
    case recents = "Recents"
    case noRecents = "No recents"
    case noSearchResults = "No search results"
}

protocol SearchViewModeling: BaseViewModel {
    var results: Property<[Character]> { get }
    var mode: Property<ViewMode> { get }
    var isLoading: Property<Bool> { get }
    
    func viewDidLoad()
    func loadRecents()
    func search(for text: String)
    func saveRecent(_ object: Character)
    func removeRecent(_ object: Character)
}

final class SearchViewModel: SearchViewModeling {
    private enum Constants {
        static let searchDelay = DispatchTimeInterval.milliseconds(500)
    }
    
    private(set) var networkService: NetworkService<Character>!
    private(set) var databaseService: DatabaseService<Character>!
    private(set) var mode = Property<ViewMode>(.noRecents)
    private(set) var isLoading = Property<Bool>(false)
    private(set) var results = Property<[Character]>([])
    private var debouncedSearch: ((String) -> Void)?
    
    init(serviceFactory: ServiceFactory) {
        networkService = serviceFactory.networkService()
        databaseService = serviceFactory.databaseService()
        
        debouncedSearch = debounce(delay:Constants.searchDelay)
        { [weak self] text in
            guard !text.isEmpty else {
                self?.loadRecents()
                self?.isLoading.value = false
                return
            }
            self?.networkService.search(for: text) { [weak self] response, error in
                guard let results = response?.results, !results.isEmpty else {
                    self?.mode.value = .noSearchResults
                    self?.results.value = []
                    self?.isLoading.value = false
                    return
                }
                self?.mode.value = .search
                self?.results.value = results
                self?.isLoading.value = false
            }
        }
    }
    
    func viewDidLoad() {
        loadRecents()
    }
    
    func search(for text: String) {
        isLoading.value = true
        debouncedSearch?(text)
    }
    
    func loadRecents() {
        if let saved = databaseService.savedObjects(), !saved.isEmpty {
            results.value = saved
            mode.value = .recents
        } else {
            results.value = []
            mode.value = .noRecents
        }
    }
    
    func saveRecent(_ object: Character) {
        databaseService.saveObject(object)
    }
    
    func removeRecent(_ object: Character) {
        if let index = results.value.index(of: object) {
            databaseService.removeObject(object)
            results.value.remove(at: index)
            if results.value.isEmpty {
                mode.value = .noRecents
            }
        }
    }
}
