//
//  FocusModeViewController.swift
//  SettingUI
//
//  Created by Chaewon on 2023/09/15.
//

import UIKit
import SnapKit

class FocusModeViewController: UIViewController {
    
    enum Section: CaseIterable {
        case first
    }
    
    let list = ["방해 금지 모드", "수면", "업무", "개인 시간"]
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: Section.first)
        
        dataSource.apply(snapshot)
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true
        configuration.separatorConfiguration.color = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .white
            cell.contentConfiguration = content
            //content.description <- 뭔지 체크하기
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .darkGray
            backgroundConfig.cornerRadius = 10
            cell.backgroundConfiguration = backgroundConfig
                        
            }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}
