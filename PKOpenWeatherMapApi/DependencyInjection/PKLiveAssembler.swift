//
//  PKLiveAssembler.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation

/**
 DI NetworkManagerProtocol implementation
 */
protocol PKNetworkAssembler: PKNetworkManagerAssembler {}

extension PKNetworkAssembler {
    
    func resolve() -> PKNetworkManagerProtocol {
        return PKNetworkManager.shared
    }
}

class PKLiveAssembler {}
extension PKLiveAssembler: PKNetworkAssembler {}
