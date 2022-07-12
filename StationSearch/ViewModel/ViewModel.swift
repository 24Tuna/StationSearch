//
//  ViewModel.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation
import Combine

final class ViewModel: ObservableObject{
    
    //MARK: - Input
    enum Inputs{
        //ユーザーの入力が終わった
        //テキストフィールドの中身をtextに代入
        case onCommit(text: String)
    }
    
    //MARK: - Outputs
    
    @Published private(set) var stationViewInputs: [StationView.Input] = []
//    @Published private(set) var lineInputs: [String] = []
    
    //エラーを表示するか
    @Published var isShowError = false
    
    //読み込みテキストを表示するか
    @Published var isLoading = false
    
    //MARK: - private
    //通信する処理が入っているService
    private let apiService: APIService
    
    //Publisherを動かす
    private let onCommitSubject = PassthroughSubject<String, Never>()
    
    //JSONを分解したものを受け取って処理する
    private let responseSubject = PassthroughSubject<StationRequest, Never>()
    //エラーが出たら動くSubject
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: APIService){
        self.apiService = apiService
        bind()
        onCommitSubject.send("JR山手線")
    }
    
    func bind(){
        onCommitSubject
            .flatMap { query in
                self.apiService.request(with: StationRequest(query: query))
            }
            .catch { error -> Empty<Welcome, Never> in
                self.errorSubject.send(error)
                return Empty()
            }
//            .map { $0.station }
            .sink { items in
                print("test:",items.response.station)
                self.stationViewInputs = self.StationInput(stations: items.response.station)
                self.isLoading = false
            }
            .store(in: &cancellable)
        
        onCommitSubject
            .map{ _ in true}
            .assign(to: \.isLoading, on:self)
            .store(in: &cancellable)
        
        errorSubject
            .sink(receiveValue: { [weak self] (error) in
                guard let self = self else{ return }
                self.isShowError = true
                self.isLoading = false
            })
    }
    
    private func StationInput(stations : [Station]) -> [StationView.Input]{
        var inputs:[StationView.Input] = []

        for station in stations{
            inputs.append(StationView.Input(name: station.name, x: station.x, y: station.y))
        }

        return inputs
    }
    
//    private func LineInput(lines : [Lines]) -> [StationView.Input]{
//        var inputs:[StationView.Input] = []
//
//        for line in lines {
//            inputs.append(PickerView.Input(name:))
//        }
//
//        return inputs
//    }
    
    

    func apply(input: Inputs){
        switch input {
        case .onCommit(let text):
            //検索して欲しい
            onCommitSubject.send(text)
        }
    }
}
