//
//  JSBridge.swift
//  JSBridge
//
//  Created by p1atdev on 2022/06/25.
//

import Foundation
import SwiftUI
import JavaScriptCore

class JSBridge: ObservableObject {
    
    private let vm = JSVirtualMachine()
    private let context: JSContext
    
    @Published var message = ""
    
    init() {
        let js = loadJSFile(fileName: "Bridge.bundle") // 拡張子jsはあとでつけるので含めない(swiftちょっとキモい)
        
        self.context = JSContext(virtualMachine: self.vm)
        
        self.context.evaluateScript(js)
        
        // 関数をインジェクト
        self.injectFunction()
    }
    
    private func injectFunction() {
        // JS側から呼び出せる関数を登録する
        // blockが何者なのかはよくわからないので誰か教えてください
        let sendMessage: @convention(block) (String) -> Void = { message in
            DispatchQueue.main.async {
                self.message = message
                NSLog("Message from JS: \(message)")
            }
        }
        
        // sendMessage という名前で登録
        self.context.setObject(sendMessage, forKeyedSubscript: "sendMessage" as NSString)
    }
    
    func calcSum(numbers: [Int]) -> Int {
        var sum = 0
        let module = self.context.objectForKeyedSubscript("Bridge") // webpack.config.jsで指定したもの
        let bridge = module?.objectForKeyedSubscript("Bridge") // 自分で書いたクラス名
        
        // Bridgeクラスのsumという関数を呼び出す
        // 引数にnumbersを渡す
        if let result = bridge?.objectForKeyedSubscript("sum").call(withArguments: [numbers]) {
            // JSValueからInt32に変換して、Intにする
            sum = Int(result.toInt32())
        }
        
        
        // 完了
        return sum
    }
    
    
}

private func loadJSFile(fileName: String) -> String? {
    // JSファイルを読み込む
    // ディレクトリとかは気にしなくていい
    let text = try? String(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "js")!)
    
    return text
}
