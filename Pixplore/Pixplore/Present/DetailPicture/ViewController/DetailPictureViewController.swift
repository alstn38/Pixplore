//
//  DetailPictureViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import UIKit

final class DetailPictureViewController: UIViewController {
    
    private let viewModel: DetailPictureViewModel
    private let input: DetailPictureViewModel.Input
    private let detailPictureView = DetailPictureView()
    
    init(viewModel: DetailPictureViewModel) {
        self.viewModel = viewModel
        self.input = DetailPictureViewModel.Input(
            viewDidLoad: CurrentValueRelay(()),
            chartSegmentedControlDidChange: CurrentValueRelay(.view)
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailPictureView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBindData()
        configureAddTarget()
        input.viewDidLoad.send(())
    }
    
    private func configureBindData() {
        let output = viewModel.transform(from: input)
        
        output.pictureData.bind { [weak self] picture in
            guard let self else { return }
            detailPictureView.configureView(picture: picture)
        }
        
        output.detailPicture.bind { [weak self] detailPicture in
            guard
                let self,
                let detailPicture
            else { return }
            detailPictureView.configureView(detailPicture: detailPicture)
        }
        
        output.detailPictureChartDataArray.bind { [weak self] chartDataEntry in
            guard let self else { return }
            detailPictureView.configureLickChart(chartDataEntry)
        }
        
        output.presentError.bind { [weak self] errorDescription in
            guard let self else { return }
            presentWarningAlert(message: errorDescription)
        }
    }
    
    private func configureAddTarget() {
        detailPictureView.chartSegmentedControl.addTarget(
            self,
            action: #selector(chartSegmentedControlDidChange),
            for: .valueChanged
        )
    }
    
    @objc private func chartSegmentedControlDidChange(_ sender: UISegmentedControl) {
        let chartPresentType = DetailPictureViewModel.chartPresentType(rawValue: sender.selectedSegmentIndex) ?? .view
        input.chartSegmentedControlDidChange.send(chartPresentType)
    }
}
