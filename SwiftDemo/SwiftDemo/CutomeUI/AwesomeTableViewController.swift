//
//  AwesomeTableViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

open class AwesomeTableViewController: UIViewController {
    public enum DataSourceStatus {
        case initLoading
        case loadingMore
        case noData
        case loadFailure
    }

    public enum DataSourceStatusView {
        case none
        case initLoading(UIView?)
        case loadingMore(UIView?)
        case noData(UIView?)
        case loadFailure(UIView?)
    }
    public static let DataSourceStatusViewTag = 12
    public var currentAdapter: MutableProperty<AwesomeTableViewAdapter?> = MutableProperty(nil)

    let tableView: UITableView
    public lazy var listSectionContext: ListSectionContext = {
        return ListSectionContext(tableView: self.tableView)
    }()
    public weak var delegate: AwesomeTableViewDelegate?

    public init(style: UITableView.Style) {
        tableView = UITableView(frame: .zero, style: style)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataStatus: DataSourceStatusView = .none {
        didSet {
            tableView.tableFooterView = nil
            view.viewWithTag(AwesomeTableViewController.DataSourceStatusViewTag)?.removeFromSuperview()
            switch dataStatus {
            case .none: break
            case .initLoading(let view):
                if let view = view {
                    view.tag = AwesomeTableViewController.DataSourceStatusViewTag
                    view.removeFromSuperview()
                    self.view.addSubview(view)
                    view.snp.makeConstraints({ (make) in
                        make.center.equalToSuperview()
                        make.width.equalTo(view.frame.size.width)
                        make.height.equalTo(view.frame.size.height)
                    })
                }
            case .loadingMore(let view):
                if let view = view {
                    view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width, height: 64))
                    tableView.tableFooterView = view
                }
            case .noData(let view):
                if let view = view {
                    view.tag = AwesomeTableViewController.DataSourceStatusViewTag
                    view.removeFromSuperview()
                    self.view.addSubview(view)
                    view.snp.makeConstraints({ (make) in
                        make.center.equalToSuperview()
                        make.width.equalTo(view.frame.size.width)
                        make.height.equalTo(view.frame.size.height)
                    })
                }
            case .loadFailure(let view):
                if let view = view {
                    if dataSource.isEmpty {
                        view.tag = AwesomeTableViewController.DataSourceStatusViewTag
                        view.removeFromSuperview()
                        self.view.addSubview(view)
                        view.snp.makeConstraints({ (make) in
                            make.center.equalToSuperview()
                            make.width.equalTo(view.frame.size.width)
                            make.height.equalTo(view.frame.size.height)
                        })
                    } else {
                        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width, height: 64))
                        tableView.tableFooterView = view
                    }
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(retryLoadData))
                    view.addGestureRecognizer(tapGestureRecognizer)
                }
            }
        }
    }

    public var dataSource: [ListSectionController] = [] {
        didSet {
            let adapter = adapterFor(dataSource: dataSource)
            tableView.delegate = adapter
            tableView.dataSource = adapter
            tableView.reloadData()
            currentAdapter.value = adapter
        }
    }
    open func adapterFor(dataSource: [ListSectionController]) -> AwesomeTableViewAdapter {
        return AwesomeTableViewAdapter(dataSource: dataSource, listSectionContext: listSectionContext)
    }
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func retryLoadData() {

    }

}
// TableView Context
public class ListSectionContext {
    let tableView: UITableView

    public internal(set) var searchKeyword: String = ""

    private var registeredCellClasses: Set<String> = []

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    public func dequeueReusableCell<T: UITableViewCell>(of cellClass: T.Type) -> T {
        let classString = String(describing: cellClass.self)
        if !registeredCellClasses.contains(classString) {
            tableView.register(cellClass, forCellReuseIdentifier: classString)
        }
        return tableView.dequeueReusableCell(withIdentifier: classString) as! T
    }
}
// MARK: 基础协议
public protocol AwesomeTableViewDelegate: class {
    func dataSignal(after: [ListSectionController]) -> SignalProducer<([ListSectionController], Bool), NSError>
    func dataSourceStatusView(status: AwesomeTableViewController.DataSourceStatus) -> UIView?
}
public protocol ListSectionController: class {
    func numberOfItems() -> Int
    func heightForItem(at index: Int) -> CGFloat
    func cellForItemAtIndex(at index: Int, context: ListSectionContext) -> UITableViewCell
}

// MARK: Adapter for Tableveiw
open class AwesomeTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    public let dataSource: [ListSectionController]
    public let listSectionContext: ListSectionContext

    public init(dataSource: [ListSectionController], listSectionContext: ListSectionContext) {
        self.dataSource = dataSource
        self.listSectionContext = listSectionContext
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionController(at: indexPath.section)?.heightForItem(at: indexPath.row) ?? 0
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionController(at: section)?.numberOfItems() ?? 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sectionController(at: indexPath.section)?.cellForItemAtIndex(at: indexPath.row, context: listSectionContext) ?? UITableViewCell()
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return (sectionController(at: section) as? ListSectionControllerWithHeaderFooter)?.viewForHeader(context: listSectionContext)
    }

    public func sectionController(at index: Int) -> ListSectionController? {
        return dataSource[safe: index]
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sectionController(at: section) as? ListSectionControllerWithHeaderFooter)?.heightForHeader(context: listSectionContext) ?? 0
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return (sectionController(at: section) as? ListSectionControllerWithHeaderFooter)?.viewForFooter(context: listSectionContext)
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (sectionController(at: section) as? ListSectionControllerWithHeaderFooter)?.heightForFooter(context: listSectionContext) ?? 0
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if dataSource.isEmpty {
            return nil
        }
        for item in dataSource {
            if !(item is IndexedListSectionController) {
                return nil
            }
        }
        return dataSource.map({ (controller) -> String in
            return (controller as! IndexedListSectionController).indexedKey()
        })
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

public protocol ListSectionControllerWithHeaderFooter: ListSectionController {
    func viewForHeader(context: ListSectionContext) -> UIView?
    func heightForHeader(context: ListSectionContext) -> CGFloat
    func viewForFooter(context: ListSectionContext) -> UIView?
    func heightForFooter(context: ListSectionContext) -> CGFloat
}
public protocol IndexedListSectionController {
    func indexedKey() -> String
}
