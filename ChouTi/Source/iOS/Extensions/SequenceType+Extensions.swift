//
//  Created by Honghao Zhang on 07/03/2016.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import Foundation

public extension Sequence {
    /**
     Return a random subset
     
     - returns: a random subset
     */
    func randomSubset() -> [Iterator.Element] {
        return self.filter { _ in Bool.random() }
    }

    /**
     If all element match predicate

     - parameter predicate: predicate criterion
     
     - returns: true if all match.
     */
    func allMatch(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        // Every element matches a predicate if no element doesn't match it
        return !self.contains { !predicate($0) }
    }
}

public extension Sequence where Iterator.Element: Hashable {
    /**
     Find all unique elements in a sequence while still maintaining the original order.
     
     - returns: Unique items with order preserved.
     */
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return self.filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}
