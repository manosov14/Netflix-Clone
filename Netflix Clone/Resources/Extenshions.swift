//
//  Extenshions.swift
//  Netflix Clone
//
//  Created by Михаил on 06.03.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
