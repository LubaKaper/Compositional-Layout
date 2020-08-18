//
//  ViewController.swift
//  Compositional-Layout
//
//  Created by Liubov Kaper  on 8/17/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    //3
    // setup enum to hold sections for collection view
    enum Section {
        case main
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView! // default if flawlayout
    //4
    // declare data source, which will be using diffable data source
    // both the SectionIdentifier and itemIdentifier need to be Hushable
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDatSource()
        // Do any additional setup after loading the view.
    }
    //2
    private func configureCollectionView() {
        
       // collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        //change collection view layout
        // do this if using Storyboard to layout your collection view
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemBackground
        
    }
    //1
    private func createLayout() -> UICollectionViewLayout {
        //1
        //create and configure the item
        // item takes up 25% of groups width
        // 100% of height
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // adds padding around each cell
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //2
        // create and configure the group
        // the group takes up 100% of the section's width
        // group's height is 25% of the sections width
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
       // let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // count here will give amount of columns
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // padding for a group
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        //3
        // configure section
        let section = NSCollectionLayoutSection(group: group)
        
        //4
        // configure the layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    //5
    // configure data source
    private func configureDatSource() {
        //1
        // setting up data source
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? LabelCell else {
                fatalError("could not dequeue LabelCell")
            }
            cell.textLabel.text = "\(item)"
            cell.backgroundColor = .systemOrange
            return cell
        })
        
        //2
        // setting up initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])// 1 section
        snapshot.appendItems(Array(1...100))
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}

