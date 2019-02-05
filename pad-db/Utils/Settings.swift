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
        self.navigationItem.title = "Settings"
        
        tableContents = [
            RadioSection(title: "Group NA", options: [
                OptionRow(text: "Red", isSelected: isUserSelectedGroup(forGroup: "Red"), action: didSelectNAGroup()),
                OptionRow(text: "Blue", isSelected: isUserSelectedGroup(forGroup: "Blue"), action: didSelectNAGroup()),
                OptionRow(text: "Green", isSelected: isUserSelectedGroup(forGroup: "Green"), action: didSelectNAGroup()),
                OptionRow(text: "None", isSelected: isUserSelectedGroup(forGroup: "None"), action: didSelectNAGroup())
                ], footer: "Groups are determined by your starter dragon color."),
            
            RadioSection(title: "Group JP", options: [
                OptionRow(text: "Red", isSelected: isUserSelectedGroupJP(forGroup: "Red"), action: didSelectJPGroup()),
                OptionRow(text: "Blue", isSelected: isUserSelectedGroupJP(forGroup: "Blue"), action: didSelectJPGroup()),
                OptionRow(text: "Green", isSelected: isUserSelectedGroupJP(forGroup: "Green"), action: didSelectJPGroup()),
                OptionRow(text: "None", isSelected: isUserSelectedGroupJP(forGroup: "None"), action: didSelectJPGroup()),

                ], footer: "Groups are determined by your starter dragon color."),
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
    
    private func didSelectNAGroup() -> (Row) -> Void {
        return { [weak self] row in
            if let option = row as? OptionRowCompatible {
                if option.isSelected {
                    UserDefaults.standard.set(option.text, forKey: "nagroup")
                    currGroupNA = option.text
                }
            }
        }
    }
    
    private func didSelectJPGroup() -> (Row) -> Void {
        return { [weak self] row in
            if let option = row as? OptionRowCompatible {
                if option.isSelected {
                    UserDefaults.standard.set(option.text, forKey: "jpgroup")
                    currGroupJP = option.text
                }
            }
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
    
    private func isUserSelectedGroup(forGroup group:String) -> Bool {
        return UserDefaults.standard.string(forKey: "nagroup") == group
    }
    
    private func isUserSelectedGroupJP(forGroup group:String) -> Bool {
        return UserDefaults.standard.string(forKey: "jpgroup") == group
    }
}
