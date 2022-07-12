//
//  ContentView.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel(apiService: APIService())
    var body: some View {
        PickerView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
