//
//  DispatchQueueExtensions.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
