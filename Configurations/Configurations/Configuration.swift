//
//  Configuration.swift
//  Configurations
//
//  Created by QDSG on 2019/5/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

struct Configuration {
    var environment: Environment {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Staging") != nil {
                return Environment.staging
            }
        }
        return Environment.production
    }
}

enum Environment: String {
    case staging = "staging"
    case production = "production"
    
    var baseURL: String {
        switch self {
        case .staging: return "https://staging-api.myservice.com"
        case .production: return "https://api.myservice.com"
        }
    }
}
