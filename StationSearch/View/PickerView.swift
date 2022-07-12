//
//  PickerView.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import SwiftUI

struct PickerView: View {
    
    @ObservedObject var viewModel:ViewModel
    
    let lines = ["JR中央線","JR中央本線","JR五日市線","JR京浜東北線","JR京葉線","JR八高線","JR南武線","JR埼京線","JR宇都宮線","JR山手線","JR常磐線各駅停車","JR常磐線快速","JR東海道本線","JR横浜線","JR横須賀線","JR武蔵野線","JR湘南新宿ライン","JR総武線","JR総武線快速","JR青梅線","JR高崎線","つくばエクスプレス線","上越新幹線","上野モノレール","京成押上線","京成本線","京成金町線","京成成田空港線","京浜急行本線","京浜急行空港線","京王線","京王新線","京王井の頭線","京王相模原線","京王高尾線","京王動物園線","京王競馬場線","北総鉄道","埼玉高速鉄道","多摩モノレール","小田急多摩線","小田急小田原線","御岳登山鉄道","新交通ゆりかもめ","東京りんかい線","東京メトロ丸ノ内分岐線","東京メトロ丸ノ内線","東京メトロ千代田線","東京メトロ半蔵門線","東京メトロ南北線","東京メトロ日比谷線","東京メトロ有楽町線","東京メトロ東西線","東京メトロ銀座線","東京メトロ副都心線","東京モノレール羽田線","東北新幹線","東急世田谷線","東急多摩川線","東急大井町線","東急東横線","東急池上線","東急田園都市線","東急目黒線","東武亀戸線","東武伊勢崎線","東武大師線","東武東上本線","東海道新幹線","西武国分寺線","西武多摩川線","西武多摩湖線","西武山口線","西武拝島線","西武新宿線","西武有楽町線","西武池袋線","西武西武園線","西武豊島線","都営三田線","都営大江戸線","都営新宿線","都営浅草線","都電荒川線","北陸新幹線","高尾登山電鉄線","日暮里・舎人ライナー","JR上野東京ライン","相鉄・JR直通線"]
//    struct Input:Identifiable,Hashable{
//        let id : UUID = UUID()
//        let line : String
//    }
//
//    let input : [Input]

    @State private var selection = "JR山手線"
    var body: some View {
        VStack{
            Picker(selection: $selection, label: Text("路線選択")) {
                ForEach(lines, id: \.self){ line in
                    Text(line)
                }//ForEach
            }//picker
            .onChange(of:selection){ newValue in
                viewModel.apply(input: .onCommit(text: selection))
            }
            if viewModel.isLoading{
                Text("読み込み中・・・")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .offset(x: 0, y:200)
            }else{
                List{
                    ForEach(viewModel.stationViewInputs){ input in
                        StationView(input: input)
                    }
                }//List
            }
            
        }//VStack
    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
