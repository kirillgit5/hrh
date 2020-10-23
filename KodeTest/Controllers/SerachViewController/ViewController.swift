//
//  ViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: Private Property
    private let viewModel: SearchViewModelProtocol = SearchViewModel()
    private let cellId = "SearchCell"
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupDesign()
        tableView.register(SearchCityFooter.self, forHeaderFooterViewReuseIdentifier: SearchCityFooter.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.reloadRecentlyRequest()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCitiesCount()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchCityCell
        cell.nameCityLabel.text = viewModel.getCityNameForCell(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            SearchCityFooter.identifier) as! SearchCityFooter
        viewModel.titleForSection.bind { (title) in
            DispatchQueue.main.async {
                footer.nameLabel.text = title
            }
        }
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.lookCity(indexPath: indexPath) {[unowned self] (viewModel) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: SegueIdentifiers.showWeatherInCity.rawValue, sender: viewModel)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showWeatherVC = segue.destination as? ShowWeatherInCityViewController else { return }
        guard let viewModel = sender as? ShowWeatherInCityViewModelProtocol else { return }
        showWeatherVC.viewModel = viewModel
    }
    
    //MARK: Private Methods
    private func setupDesign() {
        navigationController?.navigationBar.prefersLargeTitles = true
        guard let button = searchBar.value(forKey: "cancelButton") as? UIButton else { return }
        button.setTitle("Отмена", for: .normal)
        button.tintColor = .systemGray
    }
    
    
}

//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.setTextForSearch(text: searchBar.text) {[unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if viewModel.isTableViewNeedReload(text: searchBar.text ?? "", newText: text) {
            tableView.reloadData()
        }
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}


