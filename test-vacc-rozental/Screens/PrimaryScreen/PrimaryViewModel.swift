//
//  PrimaryViewModel.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import RxSwift
import RxCocoa

final class PrimaryViewModel {
    private let decodeService: DecodeDashboardDataProtocol
    private let disposeBag = DisposeBag()
    
    // Publishers
    let addressText = BehaviorRelay<String>(value: "")
    let nameText = BehaviorRelay<String>(value: "")
    let imageURL = BehaviorRelay<String?>(value: nil)
    let dataText = BehaviorRelay<String>(value: "")
    let dataArray = BehaviorRelay<[MenuItem]>(value: [])
    let dataBannerArray = BehaviorRelay<[Banner]>(value: [])
    let countNotification = BehaviorRelay<Int>(value: 0)
    
    let error = PublishRelay<Error>()
    
    
    init(decodeService: DecodeDashboardDataProtocol) {
        self.decodeService = decodeService
        bindData()
    }
    
    private func bindData() {
        decodeService.fetchDashboardData()
            .subscribe(onNext: { [weak self] data in
                self?.addressText.accept(data.myProfile.address)
                self?.nameText.accept(data.myProfile.shortName)
                self?.imageURL.accept(data.myProfile.photo)
                self?.dataText.accept(data.customerDashboard?.date ?? "")
                self?.dataArray.accept(data.customerDashboard?.menuItems ?? [])
                self?.dataBannerArray.accept(data.customerDashboard?.banners ?? [])
                self?.countNotification.accept(data.myNewNotifications)
                print(data.customerDashboard?.menuItems)
            }, onError: { [weak self] error in
                self?.error.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
