//
//  ContentView.swift
//  JSBridge
//
//  Created by p1atdev on 2022/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bridge = JSBridge()
    
    @State var numbers: [Int] = []
    @State var sum: Int = 0
    
    @State var time: String = "-"
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button {
                generateRandomNums()
            } label: {
                Text("生成")
            }
            
            HStack {
                ForEach(numbers, id: \.self) { num in
                    Text("\(num)")
                }
            }
            .frame(minHeight: 40)
            
            Button {
                
                calcSum()
                
            } label: {
                Text("計算")
            }
            
            Text("合計: \(sum)")
            
            Text("メッセージ: \(bridge.message)")
            
            Text("実行時間: \(time) ms")
            
        }
    }
    
    func generateRandomNums() {
        
        numbers = []
        
        (0..<Int.random(in: 1..<10)).forEach { num in
            numbers.append(Int.random(in: 1..<10))
        }
        
    }
    
    func calcSum() {
        let startTime = Date()
        
        self.sum = bridge.calcSum(numbers: numbers)
        
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        
        time = String(floor(Double(timeElapsed * 100000)) / 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
