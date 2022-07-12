//
//  StationView.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import SwiftUI

struct StationView: View {
    
    struct Input : Identifiable{
        let id : UUID = UUID()
        let name : String
        let x,y :Double
    }
    let input : Input
    
    var body: some View {
        HStack{
            Text(input.name)
            Spacer()
        
            VStack{
                Text("X:" + String(input.x))
                Text("Y:" + String(input.y))
            }//VStack
        }//HStack
    }
}

//struct StationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationView()
//    }
//}
