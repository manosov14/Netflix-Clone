//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Михаил on 19.02.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = "CollectionViewTableViewCell"
    
    private var titles: [Title] = []
    
    /// Создаем экземпляр collectionView
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout() // Создаем слой
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal // Задаем для слоя доступное направление прокрутки
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout) // Создаем коллекцию c указание слоя к которому она привязана
        
        collectionView.register(TitileCollectionViewCell.self, forCellWithReuseIdentifier: TitileCollectionViewCell.identifier) // регистрируем кастомную ячейку в которую будет подгружаться изображение
        return collectionView
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitileCollectionViewCell.identifier, for: indexPath) as? TitileCollectionViewCell else { return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
        
    }
    
    
}
