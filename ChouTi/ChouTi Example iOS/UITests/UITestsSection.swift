//
//  Created by Honghao Zhang on 08/13/2016.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import ChouTi
import Foundation

struct UITestsSection: TableViewSectionType {
    var headerTitle: String? = "UI Tests"
    var rows: [TableViewRowType] = {
        [
            TableViewRow(title: "TableViewCell Selection Action Test",
                         cellSelectAction: { indexPath, cell, tableView -> Void in
                            // Test accessing tableView
                            guard let tableView = cell?.tableView else {
                                return
                            }

                            tableView.deselectRow(at: indexPath, animated: true)

                            guard let cell = tableView.cellForRow(at: indexPath) else {
                                return
                            }

                            cell.textLabel?.text = "👍🏼"
            })
        ]
    }()
}
