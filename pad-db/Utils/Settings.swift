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
import CoreData

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
            
            RadioSection(title: "Region", options: [
                OptionRow(text: "NA", isSelected: isRegionSelected(forRegion: "NA"), action: didSelectRegion()),
                OptionRow(text: "NA + JP", isSelected: isRegionSelected(forRegion: "NA + JP"), action: didSelectRegion()),
                ], footer: "Region selector to display data based on your region."),
            
            Section(title: "Rebuild Data", rows: [
                TapActionRow(text: "Press Me", action: { [weak self] in self?.clearDB($0) })
                ], footer: "Deletes all database items and rebuilds it with the most recent data. This helpful when JP cards are brought over to NA, but the local app data doesn't reflect the official English name translation."),
        ]
    }
    
    private func didSelectNAGroup() -> (Row) -> Void {
        return { [weak self] row in
            if let option = row as? OptionRowCompatible {
                if option.isSelected {
                    UserDefaults.standard.set(option.text, forKey: "nagroup")
                    currGroupNA = option.text
                    changeSettings = true
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
                    changeSettings = true
                }
            }
        }
    }
    
    private func didSelectRegion() -> (Row) -> Void {
        return { [weak self] row in
            if let option = row as? OptionRowCompatible {
                if option.isSelected {
                    UserDefaults.standard.set(option.text, forKey: "region")
                    if option.text == "NA" {
                        naFilter = true
                    } else {
                        naFilter = false
                    }
                    changeSettings = true
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
    
    private func isRegionSelected(forRegion region:String) -> Bool {
        return UserDefaults.standard.string(forKey: "region") == region
    }
    
    func clearDB(_ sender: Row) {
        
        monsters.removeAll()
        skills.removeAll()
        dungeons.removeAll()
        enemySkills.removeAll()
        floors.removeAll()
        goodSkills.removeAll()
        goodMonsters.removeAll()

        wipeDatabase()
        
        let vc = LoadDataVC()
        vc.view.backgroundColor = UIColor.black
        vc.view.alpha = CGFloat(0.75)
        vc.view.isOpaque = false
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.white
        vc.view.center = self.tableView.center
        checkVersion()
        self.present(vc, animated: true, completion: nil)
        
    }
    
 
}
