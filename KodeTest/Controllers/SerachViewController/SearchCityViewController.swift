//
//  ViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class SearchCityViewController: UITableViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var cancleButton: UIButton!
    
    
    //MARK: - Private Property
    private let viewModel: SearchViewModelProtocol = SearchViewModel()
    private let cellId = "SearchCell"
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
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
        cell.nameCityLabel.textColor = viewModel.getIsSearchBarEmpty() ? .lightGray : .white
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
    
    //MARK:- Selectors
    @IBAction func cancelSearch(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    
}

//MARK: - UITextFieldDelegate
extension SearchCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.setTextForSearch(text: textField.text) {[unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if viewModel.isTableViewNeedReload(text: textField.text ?? "", newText: string) {
            tableView.reloadData()
        }
        return true
    }
}


