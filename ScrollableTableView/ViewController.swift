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
        return viewModel.itemCount
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
        if viewModel.hasMoreContent {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            let distanceToBottom = maximumOffset - currentOffset
            if distanceToBottom < scrollView.frame.size.height / 2 {
                print("scrollView.contentSize.height: \(scrollView.contentSize.height)")
                print("scrollView.frame.size.height: \(scrollView.frame.size.height)")
                print("currentOffset: \(currentOffset)")
                print("maximumOffset: \(maximumOffset)")
                print("distanceToBottom: \(distanceToBottom)")
                
                viewModel.fetchRows()
                tableView.reloadData()
            }
        }
    }
}

class ViewModel {
    private var count: Int = 1
    var rows: [Row] = []
    var hasMoreContent: Bool = false
    
    var itemCount: Int {
        return rows.count
    }
    
    func fetchRows() {
        print("fetch count: \(count)")
        for _ in 0 ..< 20 {
            if count > 50 {
                hasMoreContent = false
                return
            }
            
            let row = Row(number: count)
            rows.append(row)
            count += 1
        }
        
        hasMoreContent = true
        return
    }
}

struct Row {
    let number: Int
    var text: String {
        return String(number)
    }
}
