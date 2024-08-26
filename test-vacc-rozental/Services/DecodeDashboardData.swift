//
//  DecodeDashboardData.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//
import Foundation
import RxSwift

protocol DecodeDashboardDataProtocol {
    func fetchDashboardData() -> Observable<DashboardResponse>
}

final class DecodeDashboardData: DecodeDashboardDataProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchDashboardData() -> Observable<DashboardResponse> {
        return Observable.create { observer in
            self.networkService.fetchDashboard { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let dashboardResponse = try decoder.decode(DashboardResponse.self, from: data)
                        observer.onNext(dashboardResponse)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
