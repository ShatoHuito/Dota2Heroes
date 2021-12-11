//
//  ViewController.swift
//  Dota2Heroes
//
//  Created by Golduck Brittany on 12/7/21.
//  Copyright © 2021 Ilnur Mustafin. All rights reserved.
//

import UIKit

final class HeroListViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private let networkService = NetworkService.shared
    private var heroes = [HeroStats]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        downloadHeroesList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    // MARK: - Private methods
    
    private func configureAppearance() {
        tableView.delegate = self // иниц списка
        tableView.dataSource = self // иниц от куда идет дата
        tableView.backgroundColor = .clear // цвет строк списка
        view.backgroundColor = .lightGray // цвет фона
    }
    
    private func downloadHeroesList() { //загружается список
        networkService.downloadHeroList(completed: { [weak self] heroList in
            self?.heroes = heroList.sorted(by: { $1.localizedName > $0.localizedName })
            self?.tableView.reloadData()
        })
    }
}

    // MARK: - UITableViewDataSource

extension HeroListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //настройка строк в списке
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.text = heroes[indexPath.row].localizedName.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // количесво строк
        return heroes.count
    }
    
}

    // MARK: - UITableViewDelegate

extension HeroListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfoAboutHero", sender: self)
    }
}
