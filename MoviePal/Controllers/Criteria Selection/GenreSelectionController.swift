//
//  GenreSelectionController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit
import Magnetic

class GenreSelectionController: UIViewController, MagneticDelegate {
    
    // Outlets
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    //@IBOutlet weak var tableView: UITableView!
    
    weak var resultsDelegate: ResultsDelegate?
    
    // Bubble View
    var magnetic: Magnetic?
    
    // Data
    var genres: [Genre] = []
    
    var selectedGenres: [Genre] = [] {
        didSet {
            nextBarButton.isEnabled = !selectedGenres.isEmpty
        }
    }
    
    // Networking Client
    let movieDBClient = MovieDBClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let magneticView = MagneticView(frame: self.view.frame)
        magnetic = magneticView.magnetic
        magnetic?.magneticDelegate = self
        self.view.addSubview(magneticView)
        
        fetchGenres()
    }
    
    func fetchGenres() {
        
        // Download the genres from the movie db API
        movieDBClient.getGenres { [weak self] result in
            switch result {
            case .success(let genres):
                self?.genres = genres
                self?.setupMagneticView()
                
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func setupMagneticView() {
        
        let colours = [#colorLiteral(red: 0.6138964891, green: 0.07462634891, blue: 0.08868887275, alpha: 1),#colorLiteral(red: 0.6615397334, green: 0.2057663202, blue: 0.2145739794, alpha: 1),#colorLiteral(red: 0.7798705101, green: 0.2410033941, blue: 0.2557413578, alpha: 1)]
        
        genres.forEach { genre in
            let magnetNode = Node(text: genre.name, image: nil, color: colours.randomElement()!, radius: 50.0)
            magnetic?.addChild(magnetNode)
        }
    }
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        if let genre = genres.first(where: { $0.name == node.text }) {
            selectedGenres.append(genre)
        }
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        if let genre = genres.first(where: { $0.name == node.text }), let index = selectedGenres.firstIndex(of: genre) {
            selectedGenres.remove(at: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(selectedGenres)
        if segue.identifier == "SelectActors", let actorsSelectionController = segue.destination as? ActorSelectionController {
            // Moving to the actors view. Pass a reference to the delegate.
                resultsDelegate?.genresSelected(selectedGenres)

                actorsSelectionController.resultsDelegate = resultsDelegate
        }
    }
    
}
