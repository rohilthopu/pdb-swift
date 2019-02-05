//
//  Settings.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/5/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import QuickTableViewController

final class SettingsViewController: QuickTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        
        tableContents = [
            Section(title: "Switch", rows: [
                SwitchRow(text: "Setting 1", switchValue: true, action: { _ in }),
                SwitchRow(text: "Setting 2", switchValue: false, action: { _ in })
                ]),
            
            Section(title: "Tap Action", rows: [
                TapActionRow(text: "Tap action", action: { [weak self] in self?.showAlert($0) })
                ]),
            
            Section(title: "Navigation", rows: [
                NavigationRow(text: "CellStyle.default", detailText: .none, icon: .named("gear")),
                NavigationRow(text: "CellStyle", detailText: .subtitle(".subtitle"), icon: .named("globe")),
                NavigationRow(text: "CellStyle", detailText: .value1(".value1"), icon: .named("time"), action: { _ in }),
                NavigationRow(text: "CellStyle", detailText: .value2(".value2"))
                ], footer: "UITableViewCellStyle.Value2 hides the image view."),
            
            RadioSection(title: "Radio Buttons", options: [
                OptionRow(text: "Option 1", isSelected: true, action: didToggleSelection()),
                OptionRow(text: "Option 2", isSelected: false, action: didToggleSelection()),
                OptionRow(text: "Option 3", isSelected: false, action: didToggleSelection())
                ], footer: "See RadioSection for more details.")
        ]
    }
    
    // MARK: - Actions
    
    private func showAlert(_ sender: Row) {
        // ...
    }
    
    private func didToggleSelection() -> (Row) -> Void {
        return { [weak self] row in
            // ...
        }
    }
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "down-arrow")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc
    func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}
