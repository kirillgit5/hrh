//
//  ShowAttrectiveVCCollectionViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit


class AttractionsListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: AttractionsListViewModelProtocol!
    
    //MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showAttractionVC = segue.destination as? ShowAttractionViewController else { return }
        guard let showAttractionViewModel = sender as? ShowAttractionViewModelProtocol else { return }
        showAttractionVC.viewModel = showAttractionViewModel
    }
    
    
    //MARK: - Private Methods
    private func setupCollectionView() {
        self.collectionView!.register(AttrectionViewCell.nib(), forCellWithReuseIdentifier: AttrectionViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        customizeBackButton()
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AttractionsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 219)
    }
}

//MARK: - UICollectionViewDelegate
extension AttractionsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showAttractionViewModel = viewModel.getShowAttractionViewModel(indexPath: indexPath)
        performSegue(withIdentifier: SegueIdentifiers.showAttrection.rawValue, sender: showAttractionViewModel)
    }
}

//MARK: - UICollectionViewDataSource
extension AttractionsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttrectionViewCell.identifier, for: indexPath) as! AttrectionViewCell
        let cellViewModel = viewModel.getAttrectionCellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}
