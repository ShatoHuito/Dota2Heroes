//
//  HeroViewController.swift
//  Dota2Heroes
//
//  Created by Golduck Brittany on 12/7/21.
//  Copyright © 2021 Ilnur Mustafin. All rights reserved.
//

import UIKit

final class HeroViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let nameLabelText = "Name: "
        static let attributLabelText = "Main attribute: "
        static let attackLabeltext = "Attack type: "
        static let legsLabelText = "Legs count: "
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private properties
    
    private let networkService = NetworkService.shared
    
    // MARK: - Public properties
    
    var hero: HeroStats?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroStatsParsing()
    }
    
    // MARK: - Private methods
    
    private func heroStatsParsing() {
        guard let hero = hero else {
            return
        }
        nameLabel.text = Constants.nameLabelText + hero.localizedName.capitalized
        attributeLabel.text = Constants.attributLabelText + hero.primaryAttribute.name.capitalized
        attackLabel.text = Constants.attackLabeltext + hero.attackType
        legsLabel.text = Constants.legsLabelText + String(hero.legs)
        
        networkService.downloadImage(url: hero.img) { [weak self] data in
            self?.imageView.image = UIImage(data: data)
            self?.activityIndicator.stopAnimating()
        }
    }
    
}
