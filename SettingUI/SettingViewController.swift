//
//  SettingViewController.swift
//  SettingUI
//
//  Created by Chaewon on 2023/09/15.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    enum SettingSection: String, CaseIterable {
        case whole = "전체 설정"
        case personal = "개인 설정"
        case extra = "기타"
    }

    let settingList = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멅티프로필"], ["고객센터/도움말"]]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<SettingSection, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<SettingSection, String>()
        
        snapshot.appendSections(SettingSection.allCases)
        snapshot.appendItems(settingList[0], toSection: SettingSection.whole)
        snapshot.appendItems(settingList[1], toSection: SettingSection.personal)
        snapshot.appendItems(settingList[2], toSection: SettingSection.extra)
        
        dataSource.apply(snapshot)
        
    }

    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
        configuration.backgroundColor = .black
        configuration.separatorConfiguration.color = .lightGray
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .black
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }

}

