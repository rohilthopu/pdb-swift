//
//  SetupSaleItemUtil.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterVC {
    
    public func setupSaleItems() {
        setupSaleMP()
        setupSaleCoin()
    }
    
    public func setupSaleMP() {
        
        
        let value = monster!.value(forKey: "sellMP") as! Int
        let valueAsString = String(value)
        
        let headerLabel = makeLabel(ofSize: 20, withText: "MP Value")
        let valueLabel = makeLabel(ofSize: 16, withText: "This monster sells for " + valueAsString + " MP")
        
        
        let separator = makeSeparator()
        
        saleMPContainer.addSubview(headerLabel)
        saleMPContainer.addSubview(valueLabel)
        saleMPContainer.addSubview(separator)
        
        scrollView.addSubview(saleMPContainer)
        
        
        saleMPContainer.leadingAnchor.constraint(equalTo: devoMaterialsContainer.leadingAnchor).isActive = true
        saleMPContainer.trailingAnchor.constraint(equalTo: devoMaterialsContainer.trailingAnchor).isActive = true
        saleMPContainer.topAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor, constant: 20).isActive = true
        saleMPContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: saleMPContainer.topAnchor).isActive = true
        
        valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: saleMPContainer.centerYAnchor).isActive = true
        
        separator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: saleMPContainer.bottomAnchor).isActive = true
        
        
        
    }
    
    public func setupSaleCoin() {
        
        
        let value = monster!.value(forKey: "sellCoin") as! Int
        let valueAsString = String(value)
        
        let headerLabel = makeLabel(ofSize: 20, withText: "Coin Value")
        let valueLabel = makeLabel(ofSize: 16, withText: "This monster sells for " + valueAsString + " coins")
        
        
        let separator = makeSeparator()
        
        saleCoinContainer.addSubview(headerLabel)
        saleCoinContainer.addSubview(valueLabel)
        saleCoinContainer.addSubview(separator)
        
        scrollView.addSubview(saleCoinContainer)
        
        
        saleCoinContainer.leadingAnchor.constraint(equalTo: devoMaterialsContainer.leadingAnchor).isActive = true
        saleCoinContainer.trailingAnchor.constraint(equalTo: devoMaterialsContainer.trailingAnchor).isActive = true
        saleCoinContainer.topAnchor.constraint(equalTo: saleMPContainer.bottomAnchor, constant: 20).isActive = true
        saleCoinContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        saleCoinContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: saleCoinContainer.topAnchor).isActive = true
        
        valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: saleCoinContainer.centerYAnchor).isActive = true
        
        separator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: saleCoinContainer.bottomAnchor).isActive = true
        
        
        
    }
    
    
    
}
