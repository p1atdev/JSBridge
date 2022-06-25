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
            
        }
    }
    
    func generateRandomNums() {
        withAnimation {
            numbers = []
            
            (0..<Int.random(in: 1..<10)).forEach { num in
                numbers.append(Int.random(in: 1..<10))
            }
        }
    }
    
    func calcSum() {
        bridge.calcSum(numbers: numbers) { sum in
            withAnimation {
                self.sum = sum
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
