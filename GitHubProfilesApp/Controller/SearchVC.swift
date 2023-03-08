//
//  SearchVC.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit
import FireCache

class SearchVC: UIViewController {

    // MARK: - IBOutlets
    
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var loaderView: LoadingView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    internal let cellIdentifier = "UserCell"
    internal lazy var usersArray: [ListDisplayModel] = []
    internal var pagingModel: PagingViewModel<User, ListDisplayModel>!
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        pagingModel = PagingViewModel<User, ListDisplayModel>(endPoint: .searchUsers,
                                                              transform: { result -> [ListDisplayModel] in
            return result.map { ListDisplayModel(username: $0.login,
                                                 profileURL: $0.avatarURL,
                                                 score: "\($0.score ?? 0.0)",
                                                 typeIcon: $0.type.iconImage) }
        })
        
        customiseUI()
        searchBar.becomeFirstResponder()
    }
    
    deinit {
        pagingModel.clearDataSource()
    }
    
    // MARK: - Methods
    
    private func customiseUI() {
        searchBar.autocapitalizationType = .none
        usersTableView.tableFooterView = UIView()   //For hiding empty cells...
    }
    
    internal func loadUsers(query: String) {
        
        let loadingInfo = pagingModel.loadMoreData(query: query) { [weak self] (data, error, page) in
            
            DispatchQueue.main.async {
                
                ActivityIndicator.stopAnimating()
                
                if let data = data {
                    self?.usersArray.append(contentsOf: data)
                    self?.usersTableView.reloadData()
                    self?.loaderView.hide()
                } else if let error = error {
                    if page == 0 {
                        if (error as NSError).code != NSURLErrorCancelled {
                            self?.showErrorAlert(with: error.localizedDescription)
                        }
                    } else {
                        self?.loaderView.showMessage("Error loading data.", animateLoader: false, autoHide: 5.0)
                    }
                }
            }
        }
        
        if loadingInfo.isLoading {
            if loadingInfo.page == 0 {
                ActivityIndicator.startAnimating()
            } else {
                loaderView.showMessage("Loading...", animateLoader: true)
            }
        } else {
            loaderView.hide()
        }
    }
    
    // MARK: - Alerts
    
    private func showErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [unowned self] _ in
            if let query = self.searchBar.text, query.isEmpty == false {
                self.loadUsers(query: query)
            }
        }
        alertController.addAction(retryAction)

        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    internal func pushDetailsScene(with info: User) {
        
        guard let detailsVC = Navigation.getViewController(type: UserDetailsVC.self,
                                                           identifer: "UserDetails") else { return }
        detailsVC.detailsViewModel = DetailsViewModel(username: info.login)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        pagingModel.clearDataSource()
        usersArray.removeAll()
        
        searchText.isEmpty ? usersTableView.reloadData() : loadUsers(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        
        //We reached bottom
        if bottomEdge >= scrollView.contentSize.height,
            let query = searchBar.text, query.isEmpty == false {
                loadUsers(query: query)
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserCell
        
        let user = usersArray[indexPath.row]
        
        cell?.usernameLabel?.text = user.username
        cell?.scoreLabel?.text = user.score
        cell?.profileImageView.setImage(with: user.profileURL, placeholder: nil)
        cell?.typeIconImageView.image = user.typeIcon
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let infoObj = pagingModel.dataSource(at: indexPath.row) else { return }
        pushDetailsScene(with: infoObj)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchVC {
    
    // MARK: - Data
    
    struct ListDisplayModel {
        let username: String
        let profileURL: URL
        let score: String
        let typeIcon: UIImage
    }
}
