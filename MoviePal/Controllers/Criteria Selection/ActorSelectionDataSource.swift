//
//  ActorSelectionDataSource.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class ActorSelectionDataSource: NSObject, UITableViewDataSource {
    let actors = [Person(id: 55085, name: "Amber Heard"), Person(id: 14386, name: "Beyoncé Knowles"), Person(id: 976, name: "Jason Statham"), Person(id: 48, name: "Sean Bean"), Person(id: 9827, name: "Rose Byrne"), Person(id: 586286, name: "Hera Hilmar"), Person(id: 9625, name: "Linda Fiorentino"), Person(id: 17838, name: "Rami Malek"), Person(id: 85, name: "Johnny Depp"), Person(id: 1245, name: "Scarlett Johansson"), Person(id: 73968, name: "Henry Cavill"), Person(id: 109513, name: "Alexandra Daddario"), Person(id: 2110517, name: "Irene Arcos"), Person(id: 62, name: "Bruce Willis"), Person(id: 130640, name: "Hailee Steinfeld"), Person(id: 16483, name: "Sylvester Stallone"), Person(id: 3967, name: "Kate Beckinsale"), Person(id: 117642, name: "Jason Momoa")]
    
    
    // Mark: Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferenceCell.reuseIdentifier) as! PreferenceCell
        
        cell.preferenceDescriptionLabel.text = actors[indexPath.row].name
        
        return cell
    }
}
