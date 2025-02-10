//
//  DetailPictureViewModel.swift
//  Pixplore
//
//  Created by 강민수 on 2/10/25.
//

import DGCharts
import Foundation

final class DetailPictureViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: CurrentValueRelay<Void>
        let chartSegmentedControlDidChange: CurrentValueRelay<chartPresentType>
    }
    
    struct Output {
        let pictureData: CurrentValueRelay<Picture>
        let detailPicture: CurrentValueRelay<DetailPicture?>
        let detailPictureChartDataArray: CurrentValueRelay<[ChartDataEntry]>
        let presentError: CurrentValueRelay<String>
    }
    
    private let picture: Picture
    private var detailPicture: DetailPicture?
    private var currentChartPresentType: chartPresentType = .view
    
    private lazy var pictureDataSubject: CurrentValueRelay<Picture> = CurrentValueRelay(picture)
    private let detailPictureSubject: CurrentValueRelay<DetailPicture?> = CurrentValueRelay(nil)
    private let detailPictureChartDataArraySubject: CurrentValueRelay<[ChartDataEntry]> = CurrentValueRelay([])
    private let presentErrorSubject: CurrentValueRelay<String> = CurrentValueRelay("")
    
    init(picture: Picture) {
        self.picture = picture
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            pictureDataSubject.send(picture)
            fetchDetailPicture(imageID: picture.id)
        }
        
        input.chartSegmentedControlDidChange.bind { [weak self] chartSegmentedType in
            guard let self else { return }
            currentChartPresentType = chartSegmentedType
            getChartDataArray(chartType: currentChartPresentType, detailPicture: detailPicture)
        }
        
        return Output(
            pictureData: pictureDataSubject,
            detailPicture: detailPictureSubject,
            detailPictureChartDataArray: detailPictureChartDataArraySubject,
            presentError: presentErrorSubject
        )
    }
    
    private func fetchDetailPicture(imageID: String) {
        let endPoint = PictureEndPoint.detailPicture(imageID: imageID)
        
        NetworkService.shared.request(endPoint: endPoint, responseType: DetailPicture.self) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                detailPicture = value
                detailPictureSubject.send(value)
                getChartDataArray(chartType: currentChartPresentType, detailPicture: value)
            case .failure(let error):
                presentErrorSubject.send(error.description)
            }
        }
    }
    
    private func getChartDataArray(chartType: chartPresentType, detailPicture: DetailPicture?) {
        guard let detailPicture else { return }
        var chartDataEntry: [ChartDataEntry] = []
        let chartData = chartType.rawValue == 0
        ? detailPicture.views.historical.statistic
        : detailPicture.downloads.historical.statistic
        
        for (index, value) in chartData.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(value.views))
            chartDataEntry.append(dataEntry)
        }
        
        detailPictureChartDataArraySubject.send(chartDataEntry)
    }
}

// MARK: - chartPresentType
extension DetailPictureViewModel {
    
    enum chartPresentType: Int {
        case view
        case download
    }
}
