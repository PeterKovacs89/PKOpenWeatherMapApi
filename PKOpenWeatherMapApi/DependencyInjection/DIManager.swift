//
//  DIManager.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation

/**
 DI NetworkManagerProtocol implementation
 */
protocol PKNetworkAssembler: NetworkManagerAssembler {}

extension PKNetworkAssembler {
    
    func resolve() -> NetworkManagerProtocol {
        return PKNetworkManager.shared
    }
}

class PKLiveAssembler {}
extension PKLiveAssembler: PKNetworkAssembler {}
