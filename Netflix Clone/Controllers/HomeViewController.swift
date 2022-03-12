//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Михаил on 19.02.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "upcoming Movies",
        "Top Rated"
    ]
    
    
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)  // Создание экземпляра класса
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier) // Регистрация созданного экземпляра
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func fetchData() {
        //        APICaller.shared.getTrendingMovies { results in
        //            switch results {
        //
        //            case .success(let movies):
        //                print(movies)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        
        
        //        APICaller.shared.getTrendingsTvs {  in
        
        //        }
        
        
        //        APICaller.shared.getUpCommingMovies { _ in
        //
        //        }
        
                APICaller.shared.getTopRated { _ in
        
                }
        
        
        
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y + 10, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOfSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
