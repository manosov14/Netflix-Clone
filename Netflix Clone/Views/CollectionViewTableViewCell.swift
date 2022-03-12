//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Михаил on 19.02.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    /// Создаем экземпляр collectionView
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout() // Создаем слой
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal // Задаем для слоя доступное направление прокрутки
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout) // Создаем коллекцию c указание слоя к которому она привязана
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell") // Регистрируемся в ячейке. Идентификатор произвольный.
        return collectionView
        
    }()
    
    static let identifier = "CollectionViewTableViewCell"
    
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
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
   
}
