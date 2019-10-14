//
//  ViewController.swift
//  ScrollableTableView
//
//  Created by 桑江 望 on 2019/10/14.
//  Copyright © 2019 桑江 望. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchRows()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError()
        }
        cell.textLabel?.text = viewModel.rows[indexPath.row].text
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let distanceToBottom = maximumOffset - currentOffset
        if distanceToBottom < 500 {
            viewModel.fetchRows()
            tableView.reloadData()
        }
    }
}

class ViewModel {
    private var count: Int = 1
    var rows: [Row] = []
    
    func fetchRows() {
        print("fetch count: \(count)")
        for _ in 0 ..< 20 {
            let row = Row(number: count)
            rows.append(row)
            count += 1
        }
    }
}

struct Row {
    let number: Int
    var text: String {
        return String(number)
    }
}
